# Class ApplicationController
class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  #after_action :verify_authorized, except: :index
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :set_locale#, :initialize_omniauth_state
  
# def find_user_name
#   if user_signed_in?
#     return user.user_name
#   end
# end

  def get_user_name
    if user_signed_in?
      return current_user
    end
  end

  def get_user_session
    if user_signed_in?
      return user_session
    end
  end

  def get_admin_name
    if admin_signed_in?
      return current_admin
    end
  end

  def get_admin_session
    if admin_signed_in?
      return admin_session
    end
  end
  #end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  private

  def user_not_authorized
    flash[:warning] = "You are not authorized to perform this action."
    redirect_to(request.referer || articles_path)
  end
  #protected

  #def authenticate_admin!
  #  unless current_user.present? && current_user.is_admin?
  #    flash[:danger] = "Unautorized to enter this section"
  #    redirect_to root_path
  #  end
  #end

  #protected

  #def initialize_omniauth_state
  #  session['omniauth.state'] = response.headers['X-CSFR-Token'] = form_authenticity_token
  #end
end
