class InstructorController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  authorize_resource class: false

  def home
    @students = User.where(role: "student").count
    @courses = Course.count
  end

  def index
    if params[:course]
      course = Course.find(params[:course])
      @students = course.users.where(role: "student")
    else
      @students = User.where(role: "student")
    end
  end

  def show
  end

  def new
    @student = User.new
  end

  def create
    @student = User.new(student_params)
    @student.role = "student"

    respond_to do |format|
      if @student.save
        format.html { redirect_to students_path, notice: 'Student was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @student.update(update_student_params)
        format.html { redirect_to students_path, notice: 'Student was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @student.courses.any?
        flash[:error] = 'Student cannot be deleted because it is related to courses.'
        format.html { redirect_to students_path }
      else
        @student.destroy
        format.html { redirect_to students_path, notice: 'Student was successfully destroyed.' }
      end
    end
  end

  def remove_student_course
    @course = Course.find(params[:course])
    @student = @course.user_courses.find_by(user_id: params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to courses_path, notice: 'Student was successfully removed from course.' }
    end
  end

  private

  def student_params
    params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation)
  end

  def update_student_params
    params.require(:user).permit(:name, :surname, :email)
  end

  def set_student
    @student = User.find(params[:id])
  end
end
