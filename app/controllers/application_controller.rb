class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected
  def authenticate_user!
    if user_signed_in?
      if current_user.apps.include?(request.host) || request.host == "localhost"
        super
      else
        ## if you want render 404 page
        # return render json: {host: request.host}
        render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
      end
    else
      redirect_to new_user_session_path
    end
  end
end
