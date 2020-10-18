class Course < ApplicationRecord
  has_many :assessment_items
  has_many :grades
  has_many :user_courses
  has_many :users, through: :user_courses

  validates_presence_of :name, :code, :semester
  validates :code, length: {maximum: 6, minimum: 5}
  validates :name,length: {maximum: 50}
  validates :semester,length: {maximum: 10}
  validates :catalog_data,length: {maximum: 500}
end
