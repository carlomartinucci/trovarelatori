class Backend::BaseController < ApplicationController
  layout "backend/application"

  before_action :set_highlighted_themes
  before_action :set_favorite_themes
  before_action :set_favorite_arguments
  before_action :set_favorite_theorems
  # before_action :get_breadcrumbs
  # before_action :set_breadcrumbs
  before_action :set_title
  before_action :set_description
  before_action :set_author

  include ActionView::Helpers::TextHelper

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to root_path }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  def home
    # if current_user
      # redirect_to backend_themes_path
      # return
    # end
  end

  def search
    if params[:gsearch].present?
      @claims = Claim.search_by_value(params[:gsearch]).includes(:theorems)
    end
  end


  private
    def set_title
      @title ||= "Spiegami - Backend"
    end

    def set_description
      @description ||= "La pagina di Backend di Spiegami, per i collaboratori."
    end

    def set_author
      @author ||= "Carlo Martinucci"
    end

    def set_root_breadcrumb
      add_breadcrumb "home", root_path
    end

    def set_highlighted_themes
      @highlighted_themes ||= Theme.all
    end

    def set_favorite_themes
      @favorite_themes = current_user.favorite_themes if current_user
      @favorite_theme_ids = @favorite_themes.pluck(:id) if current_user
    end

    def set_favorite_arguments
      @favorite_arguments = current_user.favorite_arguments if current_user
      @favorite_argument_ids = @favorite_arguments.pluck(:id) if current_user
    end

    def set_favorite_theorems
      @favorite_theorems = current_user.favorite_theorems if current_user
      @favorite_theorem_ids = @favorite_theorems.pluck(:id) if current_user
    end

    def get_breadcrumbs
      p params
      return if !params[:action].in?(["index", "show", "new", "edit"]) ||
        params[:controller].starts_with?('devise') ||
        params[:controller].starts_with?('api') ||
        params[:controller].starts_with?('themes')
      session[:breadcrumbs_navigation] ||= []
      this_path = request.path

      this_title = ""
      [Argument, Theorem, Claim].each do |my_model|
        if params[:controller].ends_with? my_model.model_name.route_key
          if params[:action] == "index"
            this_title = my_model.model_name.human(count: 2)
          else
            model = my_model.find_by(id: params[:id])
            if model.present?
              p my_model.model_name.human
              p model.breadcrumb
              this_title = my_model.model_name.human + ": " + (model ? model.breadcrumb.to_s : params[:id])
            else
              this_title = my_model.model_name.human
            end
          end
          break
        end
      end

      index = session[:breadcrumbs_navigation].map(&:last).index(this_path)
      if index
        session[:breadcrumbs_navigation] = session[:breadcrumbs_navigation].slice(0..index)
      else
        session[:breadcrumbs_navigation] << [this_title, this_path]
      end
    end

    def set_breadcrumbs
      if current_user
        session[:breadcrumbs_navigation] ||= []
        session[:breadcrumbs_navigation].each do |this_title, this_path|
          add_breadcrumb "<span>#{truncate this_title, length: 60}</span>".html_safe, this_path
        end
      else
        session[:breadcrumbs_navigation] = []
      end
    end

    def check_psw
      raise if params[:psw] != "xyOD3MNIVr2RduXsKqC9" 
    end
end
