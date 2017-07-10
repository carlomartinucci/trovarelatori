class API::V1::ClaimsController < API::V1::BaseController  
  skip_before_action :destroy_session

  def find_or_create
    value = params[:value]
    claim = Claim.where(value: value).first_or_create do |c|
      c.user_id = current_user.id if c.user_id.blank? && current_user
    end
    render json: claim
  end

  def search
    @claims = Claim.search_by_value(params[:q]) if params[:q].present?
  end

end
