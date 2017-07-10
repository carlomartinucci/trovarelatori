class API::V1::ArgumentsController < API::V1::BaseController
  before_action :set_argument, only: [:export, :import, :favorite, :unfavorite]
  authorize_resource

  def export
    render json: { "theorems" => @argument.ordered_theorems }
  end

  def import
    theorems = params[:theorems].as_json
    @argument.import_theorems theorems
    render json: @argument.theorems
  end

  # PUT /arguments/:id/favorite
  def favorite
    @argument.favorites.where(user_id: current_user.id).first_or_create
    redirect_to request.referrer
  end

  # DELETE /arguments/:id/unfavorite
  def unfavorite
    @argument.favorites.find_by(user_id: current_user.id).try(:destroy)
    redirect_to request.referrer
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_argument
      @argument = Argument.find(params[:id])
    end
end
