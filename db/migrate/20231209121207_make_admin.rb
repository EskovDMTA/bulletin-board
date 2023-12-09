# frozen_string_literal: true

class MakeAdmin < ActiveRecord::Migration[7.0]
  def change
    user = User.find_by(email: 'DmtEskov@gmail.com')
    user&.update(admin: true)
  end
end
