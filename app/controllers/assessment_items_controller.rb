class AssessmentItemsController < ApplicationController
  before_action :set_assessment_item, only: [:show, :edit, :update, :destroy]
  before_action :set_course, only: [:new, :create, :edit, :update]
  load_and_authorize_resource

  # GET /assessment_items
  # GET /assessment_items.json
  def index
    @assessment_items = AssessmentItem.all.includes(:course)
  end

  # GET /assessment_items/1
  # GET /assessment_items/1.json
  def show
  end

  # GET /assessment_items/new
  def new
    @assessment_item = AssessmentItem.new
  end

  # GET /assessment_items/1/edit
  def edit
  end

  # POST /assessment_items
  # POST /assessment_items.json
  def create
    @assessment_item = AssessmentItem.new(assessment_item_params)

    respond_to do |format|
      if @assessment_item.save
        format.html { redirect_to @assessment_item, notice: 'Assessment item was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /assessment_items/1
  # PATCH/PUT /assessment_items/1.json
  def update
    respond_to do |format|
      if @assessment_item.update(assessment_item_params)
        format.html { redirect_to @assessment_item, notice: 'Assessment item was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /assessment_items/1
  # DELETE /assessment_items/1.json
  def destroy
    respond_to do |format|
      if @assessment_item.grades.any?
        flash[:error] = 'Assessment item cannot be deleted because it is related to grades.'
        format.html { redirect_to assessment_items_url }
      else
        @assessment_item.destroy
        format.html { redirect_to assessment_items_url, notice: 'Assessment item was successfully destroyed.' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assessment_item
      @assessment_item = AssessmentItem.find(params[:id])
    end

  def set_course
    @courses = Course.pluck(:name, :id)
  end

    # Only allow a list of trusted parameters through.
    def assessment_item_params
      params.require(:assessment_item).permit(:name, :weight, :course_id)
    end
end
