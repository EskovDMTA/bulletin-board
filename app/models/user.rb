# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bulletins, dependent: :destroy
  class << self
    def create_with_omniauth(auth)
      create! do |user|
        user.provider = auth['provider']
        user.uid = auth['uid']
        user.name = auth['info']['name']
        user.email = auth['info']['email']
      end
    end
  end
end
