class SearchController < ApplicationController
  before_action :set_query
  before_action :search_q

  def index
    respond_to do |format|
      format.html do
        if @q.present?
          render :show
        else
          render :index
        end
      end
      format.js { render :show }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

    def set_query
      @q = params[:q]
    end

    def search_q
      search @q
    end

    def search(q)
      @searchs = current_user.correlated_searchs q
      return if q.blank?
      @users   = User.all.select { |user| q.downcase.in?(user.name.downcase) }
      @topics  = Topic.search_by_keywords q
      expert_ids = KnownTopic.where(topic_id: @topics.pluck(:id)).pluck(:user_id)
      @experts = User.where(id: expert_ids).each do |u|
        u.expertise = @topics.known_topics u
      end.sort_by { |u| - u.score(@topics) }
    end
end
