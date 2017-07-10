class API::V1::ThemesController < API::V1::BaseController
  before_action :set_theme, only: [:import, :favorite, :unfavorite]
  authorize_resource

  def import
    arguments = params[:arguments].as_json
    arguments.each do |argument_name, theorems|
      argument = Argument.where(name: argument_name, theme_id: @theme.id).first_or_create
      argument.import_theorems_old theorems
    end
    render text: "ok"
  end

  # PUT /themes/:id/favorite
  def favorite
    @theme.favorites.where(user_id: current_user.id).first_or_create
    redirect_to request.referrer
  end

  # DELETE /themes/:id/unfavorite
  def unfavorite
    @theme.favorites.find_by(user_id: current_user.id).try(:destroy)
    redirect_to request.referrer
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_theme
      @theme = Theme.find(params[:id])
    end
end
