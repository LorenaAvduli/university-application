class StudentController < ApplicationController
  before_action :authenticate_user!
  authorize_resource class: false

  def home
    @courses = current_user.courses
  end

  def grades
    if params[:course]
      @grades = current_user.courses.find(params[:course]).grades
    else
      @grades = current_user.grades
    end
  end
end
