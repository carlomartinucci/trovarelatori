class API::V1::TheoremsController < API::V1::BaseController
  before_action :set_theorem, only: [:export, :import, :favorite, :unfavorite]
  authorize_resource

  def export
  end

  def import
  end

  # PUT /theorems/:id/favorite
  def favorite
    @theorem.favorites.where(user_id: current_user.id).first_or_create
    redirect_to request.referrer
  end

  # DELETE /theorems/:id/unfavorite
  def unfavorite
    @theorem.favorites.find_by(user_id: current_user.id).try(:destroy)
    redirect_to request.referrer
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_theorem
      @theorem = Theorem.find(params[:id])
    end
end
