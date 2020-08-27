class Base < ApplicationRecord
  validates :base_id, inclusion: {in: 0..999 }, uniqueness: true
  validates :name, presence: true, length: { maximum: 30 }, uniqueness: true
  validates :attendance_status, presence: true
end