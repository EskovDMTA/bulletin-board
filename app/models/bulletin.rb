# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  has_one_attached :image

  belongs_to :user, inverse_of: :bulletins, optional: false
  belongs_to :category, inverse_of: :bulletins, optional: false

  validates :title, length: { minimum: 5, maximum: 50 }, presence: true
  validates :description, length: { minimum: 5, maximum: 1000 }, presence: true
  validates :image, attached: true, size: {
    less_than: 5.megabytes,
    content_type: %i[jpeg jpg png]
  }, presence: true

  aasm column: 'state' do
    state :draft, initial: true
    state :under_moderation
    state :published
    state :rejected
    state :archived

    event :to_moderate do
      transitions from: :draft, to: :under_moderation
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :reject do
      transitions from: %i[draft under_moderation], to: :rejected
    end

    event :archive do
      transitions to: :archived
    end
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[category image_attachment image_blob user]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[state title category]
  end

  def self.states
    @states ||= aasm.states.map(&:name)
  end
end
