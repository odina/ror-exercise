class WebSurveysController < ApplicationController
  before_action :set_web_survey, only: [:show, :edit, :update, :destroy]

  # GET /web_surveys
  # GET /web_surveys.json
  def index
    @web_surveys = WebSurvey.all
  end

  # GET /web_surveys/1
  # GET /web_surveys/1.json
  def show
  end

  # GET /web_surveys/new
  def new
    @web_survey = WebSurvey.new
  end

  # GET /web_surveys/1/edit
  def edit
  end

  # POST /web_surveys
  # POST /web_surveys.json
  def create
    @web_survey = WebSurvey.new(web_survey_params)

    respond_to do |format|
      if @web_survey.save
        format.html { redirect_to @web_survey, notice: 'Web survey was successfully created.' }
        format.json { render :show, status: :created, location: @web_survey }
      else
        format.html { render :new }
        format.json { render json: @web_survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /web_surveys/1
  # PATCH/PUT /web_surveys/1.json
  def update
    respond_to do |format|
      if @web_survey.update(web_survey_params)
        format.html { redirect_to @web_survey, notice: 'Web survey was successfully updated.' }
        format.json { render :show, status: :ok, location: @web_survey }
      else
        format.html { render :edit }
        format.json { render json: @web_survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /web_surveys/1
  # DELETE /web_surveys/1.json
  def destroy
    @web_survey.destroy
    respond_to do |format|
      format.html { redirect_to web_surveys_url, notice: 'Web survey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_web_survey
      @web_survey = WebSurvey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def web_survey_params
      params.require(:web_survey).permit(:title, :shortlink_slug)
    end
end
