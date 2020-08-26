class BasesController < ApplicationController

  $attendance = %w(出勤 退勤)

  def index
    @bases = Base.all
    unless current_user.admin?
      flash[:danger] = "閲覧権限がありません。"
      redirect_to root_url
    end
  end
  
  def edit
    @base = Base.find(params[:id])
  end
  
  def update
    @base = Base.find(params[:id])
    if @base.update_attributes(base_params)
      flash[:success] = "拠点情報を編集しました。"
      redirect_to bases_url
    else
      render :edit
    end
  end
  
  def edit_basic_info
  end
  
  def update_basic_info
  end

  def create
    @base = Base.new(base_params)
    if @base.save
      flash[:success] = "拠点情報を追加しました。"
      redirect_to bases_url @base
    else
      render :new
    end
  end
  
  def new
    @base = Base.new
  end

  def destroy
    @base.destroy
    flash[:success] = "#{@base.name}のデータを削除しました。"
    redirect_to bases_url
  end
  
  private
  
    def base_params
      params.require(:base).permit(:base_id, :name, :attendance_sort)
    end
  
end