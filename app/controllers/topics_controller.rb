class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :set_theme, only: [:show]

  # GET /topics
  # GET /topics.json
  def index
    @themes = Theme.includes(topics: :known_topics)
    render layout: "knowledge"
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @knowledge = params[:knowledge] || "all"
    known_topics_grouped = @topic.known_topics.group_by(&:knowledge)
    @users_grouped = {}
    KnownTopic::KNOWLEDGES.each do |knowledge|
      known_topics = known_topics_grouped[knowledge] || KnownTopic.none
      @users_grouped[knowledge] = User.where(id: known_topics.map(&:user_id))
    end
    render layout: "knowledge"
  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to request.referer, notice: 'Argomento creato correttamente.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    def set_theme
      @theme = @topic.theme
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:theme_id, :name)
    end
end
