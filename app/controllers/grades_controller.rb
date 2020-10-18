class GradesController < ApplicationController
  before_action :set_grade, only: [:show, :edit, :update, :destroy]
  before_action :set_students_courses, only: [:new, :edit, :create, :update]
  load_and_authorize_resource

  # GET /grades
  # GET /grades.json
  def index
    @grades = Grade.all.includes(:user, :course, :assessment_item)
  end

  # GET /grades/1
  # GET /grades/1.json
  def show
  end

  # GET /grades/new
  def new
    @grade = Grade.new
  end

  # GET /grades/1/edit
  def edit
  end

  def assessment_items
    @assessment_items = AssessmentItem.where(course_id: params[:course_id]).select(:name, :id)
    render json: @assessment_items
  end

  def courses
    @courses = User.where(role: "student").find(params[:user_id]).courses.select(:name, :id)
    render json: @courses
  end

  # POST /grades
  # POST /grades.json
  def create
    @grade = Grade.new(grade_params)

    respond_to do |format|
      if @grade.save
        format.html { redirect_to @grade, notice: 'Grade was successfully created.' }
        format.json { render :show, status: :created, location: @grade }
      else
        format.html { render :new }
        format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grades/1
  # PATCH/PUT /grades/1.json
  def update
    respond_to do |format|
      if @grade.update(grade_params)
        format.html { redirect_to @grade, notice: 'Grade was successfully updated.' }
        format.json { render :show, status: :ok, location: @grade }
      else
        format.html { render :edit }
        format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grades/1
  # DELETE /grades/1.json
  def destroy
    @grade.destroy
    respond_to do |format|
      format.html { redirect_to grades_url, notice: 'Grade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grade
      @grade = Grade.find(params[:id])
    end

  def set_students_courses
    @students = User.where(role: :student).map{ |student|  ["#{student.name} #{student.surname}", student.id]}
    @courses = Course.all.pluck(:name, :id)
  end

    # Only allow a list of trusted parameters through.
    def grade_params
      params.require(:grade).permit(:user_id, :course_id, :assessment_item_id, :exam, :score)
    end
end
