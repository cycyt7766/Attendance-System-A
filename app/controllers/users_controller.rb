class UsersController < ApplicationController
  before_action :set_user,
                 only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :logged_in_user,
                 only: [:index, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :admin_user, only: [:destroy, :edit_basic_info, :update_basic_info]
  before_action :set_one_month, only: :show

  def index
    @users = User.all
    respond_to do |format|
      format.html do
        # html用の処理
      end
      format.csv do
        # csv用の処理
        send_data render_to_string, filename: "(ファイル名).csv", type: :csv
      end
    end
    unless current_user.admin?
      flash[:danger] = "閲覧権限がありません。"
      redirect_to root_url
    end
  end
  
  def import
    if params[:file].blank?
      flash[:danger] = "インポートするCSVファイルを選択してください。"
      redirect_to users_url
    else
      User.import(params[:file])
      flash[:success] = "CSVファイルをインポートしました。"
      redirect_to users_url
    end
  end

  def show
    @worked_sum = @attendances.where.not(started_at: nil).count
    @user = User.find(params[:user_id]) if @user.blank?
    unless current_user?(@user) || current_user.admin?
      flash[:danger] = "編集権限がありません。"
      redirect_to root_url
    end
  end

  def new
    
    # 管理者のみ新規アカウント作成可能
    if logged_in? && !current_user.admin?
      flash[:info] = 'すでにログインしています。'
      redirect_to root_url
    end
    
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    unless current_user.admin? && !current_user?(@user)
      flash[:danger] = "編集権限がありません。"
      redirect_to root_url
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "#{@user.name}の基本情報を編集しました。"
      redirect_to users_url
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end

  def edit_basic_info
  end

  def update_basic_info
    if @user.update_attributes(basic_info_params)
      flash[:success] = "#{@user.name}の基本情報を更新しました。"
    else
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>"
                        + @user.errors.full_messages.join("<br>")
    end
    redirect_to users_url
  end

  private

    def self.import(file)
      CSV.foreach(file.path, headers: true) do |row|
        user = new
        user.attributes = row.to_hash.slice(*updatable_attributes)
        user.save!
      end
    end

    def user_params
      params.require(:user).permit(:name, :email, :affiliation, :employee_number, :uid,
                                   :password, :password_confirmation,
                                   :basic_work_time, :designated_work_start_time, :designated_work_end_time)
    end

end