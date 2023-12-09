# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  helper_method :current_user

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    redirect_to (request.referer || root_path), notice: t("#{policy_name}.#{exception.query}",
                                                          scope: 'pundit',
                                                          default: :default)
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
