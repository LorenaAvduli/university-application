class UserCourse < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates_uniqueness_of :user_id, scope: :course_id
end
