# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  helper_method :current_user

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    redirect_to (request.referer || root_path), notice: t('login_or_registration', scope: 'pundit')
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
