class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :set_course_students, only: [:register_student, :register]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  def register_student
    @user_course = UserCourse.new
  end

  def register
    @user_course = UserCourse.new(register_params)
    @user_course.course = @course

    if @user_course.save
      redirect_to courses_path, notice: 'User was successfully registered.'
    else
      render :register_student
    end


  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    respond_to do |format|
      if @course.assessment_items.any?
        flash[:error] = 'Course cannot be deleted because it is related to some assessment items.'
        format.html { redirect_to courses_url }
      else
        @course.destroy
        format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      end

    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

  def set_course_students
    @course = Course.find(params[:id])
    @students = User.where(role: "student").map{ |user| [user.full_name, user.id]}
  end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:code, :name, :semester, :catalog_data)
    end

  def register_params
    params.require(:user_course).permit(:user_id)
  end
end
