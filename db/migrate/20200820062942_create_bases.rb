class CreateBases < ActiveRecord::Migration[5.1]
  def change
    create_table :bases do |t|
      t.integer :base_id
      t.string :name
      t.string :attendance_sort

      t.timestamps
    end
  end
end
