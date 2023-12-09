# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def admin_index?
    user&.admin?
  end

  def admin_new?
    admin_index?
  end

  def admin_create?
    admin_index?
  end

  def index?
    true
  end

  def home?
    false
  end

  def new?
    user
  end

  def create?
    new?
  end
end
