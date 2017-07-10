class KnownTopicsController < ApplicationController
  before_action :set_known_topic, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:update, :create]

  # GET /known_topics
  # GET /known_topics.json
  def index
    @known_topics = KnownTopic.all
  end

  # GET /known_topics/1
  # GET /known_topics/1.json
  def show
  end

  # GET /known_topics/new
  def new
    @known_topic = KnownTopic.new
  end

  # GET /known_topics/1/edit
  def edit
  end

  # POST /known_topics
  # POST /known_topics.json
  def create
    @from = params[:from]
    @known_topic = KnownTopic.new(known_topic_params)

    respond_to do |format|
      if @known_topic.save
        format.html { redirect_to request.referer }
        format.js { render "update" }
        format.json { render :show, status: :created, location: @known_topic }
      else
        format.html { render :new }
        format.json { render json: @known_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /known_topics/1
  # PATCH/PUT /known_topics/1.json
  def update
    @from = params[:from]
    respond_to do |format|
      if @known_topic.update(known_topic_params)
        format.html { redirect_to request.referer }
        format.js {}
        format.json { render :show, status: :ok, location: @known_topic }
      else
        format.html { render :edit }
        format.js { render js: "window.location.reload();"}
        format.json { render json: @known_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /known_topics/1
  # DELETE /known_topics/1.json
  def destroy
    @from = params[:from]
    @known_topic.update(knowledge: :unknown)
    @known_topic.destroy
    respond_to do |format|
      format.html { redirect_to known_topics_url, notice: 'Known topic was successfully destroyed.' }
      format.js { render "update" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_known_topic
      @known_topic = KnownTopic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def known_topic_params
      params.require(:known_topic).permit(:user_id, :topic_id, :knowledge)
    end
end
