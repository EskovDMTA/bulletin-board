# frozen_string_literal: true

module Web
  class AuthController < Web::ApplicationController
    def callback
      auth = request.env['omniauth.auth']
      user = User.find_by(provider: auth['provider'], uid: auth['uid']) || User.create_with_omniauth(auth)
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Signed in successfully!'
    end

    def destroy
      session[:user_id] = nil
      redirect_to root_path, notice: 'Logout successfully!'
    end
  end
end
