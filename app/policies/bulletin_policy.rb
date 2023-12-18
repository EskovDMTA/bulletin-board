# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def admin?
    user&.admin?
  end

  def index?
    true
  end

  def new?
    user
  end

  def create?
    new?
  end
end
