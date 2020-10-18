class HomeController < ApplicationController
  before_action :set_course, only: :assessment_items

  def index
    @courses = Course.all
  end

  def assessment_items
    @assessment_items = @course.assessment_items.includes(:grades)
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end
end
