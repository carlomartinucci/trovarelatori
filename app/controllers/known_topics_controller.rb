class KnownTopicsController < ApplicationController
  before_action :set_known_topic, only: %i[update destroy]
  skip_before_action :verify_authenticity_token, only: %i[update create]
  authorize_resource

  # POST /known_topics
  def create
    @from = params[:from]
    @known_topic = KnownTopic.new(known_topic_params)
    @known_topic.save

    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js { render 'update' }
    end
  end

  # PATCH/PUT /known_topics/1
  def update
    updated = @known_topic.update(known_topic_params)

    respond_to do |format|
      format.html { redirect_to request.referer }
      if updated
        @from = params[:from]
        format.js {}
      else
        format.js { render js: 'window.location.reload();' }
      end
    end
  end

  # DELETE /known_topics/1
  def destroy
    @from = params[:from]
    @known_topic.update(knowledge: :unknown)
    @known_topic.destroy
    respond_to do |format|
      format.html { redirect_to known_topics_url, notice: 'Known topic was successfully destroyed.' }
      format.js { render 'update' }
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
