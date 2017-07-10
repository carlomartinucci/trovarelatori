class StaticController < ApplicationController
  def home
    if current_user
      redirect_to searchs_path
    else
      redirect_to new_user_session_path
    end
  end

  def help
    render layout: "knowledge"
  end
end
