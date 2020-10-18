class AssessmentItem < ApplicationRecord
  belongs_to :course
  has_many :grades

  validates_presence_of :name, :weight
  validate :validate_course_weight

  validates :name, length: {maximum: 30}
  validates :weight, numericality: { greater_than_or_equal_to: 0, :less_than_or_equal_to => 1}

  private

  def validate_course_weight
    if self.course && self.weight
      current_total = self.course.assessment_items.sum(:weight)
      if current_total + self.weight > 1
        errors.add(:weight, "Total weight for course #{self.course.name} must be equal to 1. Current total weight is: #{current_total}")
      end
    end
  end
end
