# class ThemesController < ApplicationController
#   # POST /themes
#   # POST /themes.json
#   def create
#     @theme = Theme.new(theme_params)

#     respond_to do |format|
#       if @theme.save
#         format.html { redirect_to request.referer, notice: 'Tema creato con successo.' }
#         format.json { render :show, status: :created, location: @theme }
#       else
#         format.html { render :new }
#         format.json { render json: @theme.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   private
#     def theme_params
#       params.require(:theme).permit(:name)
#     end

# end
