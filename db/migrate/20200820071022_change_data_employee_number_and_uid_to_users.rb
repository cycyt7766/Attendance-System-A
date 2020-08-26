class ChangeDataEmployeeNumberAndUidToUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :employee_number, :integer
    change_column :users, :uid, :integer
  end
end
