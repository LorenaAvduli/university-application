class Grade < ApplicationRecord
  belongs_to :user
  belongs_to :course
  belongs_to :assessment_item

  validates_presence_of :exam, :score
  validates :score, numericality: {only_integer: true, greater_than_or_equal_to: 0, :less_than_or_equal_to => 120}
end
