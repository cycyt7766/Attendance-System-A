class RenameAttendanceSortColumnToBases < ActiveRecord::Migration[5.1]
  def change
    rename_column :bases, :attendance_sort, :attendance_status
  end
end
