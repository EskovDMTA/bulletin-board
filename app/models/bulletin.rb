# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  aasm column: 'state' do
    state :draft, initial: true
    state :under_moderation
    state :published
    state :rejected
    state :archived

    event :submit_for_moderation do
      transitions from: :draft, to: :under_moderation
    end

    event :approve do
      transitions from: :under_moderation, to: :published
    end

    event :reject do
      transitions from: %i[draft under_moderation], to: :rejected
    end

    event :archive do
      transitions to: :archived
    end
  end
  belongs_to :user, inverse_of: :bulletins, optional: false
  belongs_to :category, inverse_of: :bulletins, optional: false

  has_one_attached :image do |attachable|
    attachable.variant :bulletin_image, resize_to_limit: [300, 300]
  end

  validates :title, :description, :image, presence: true
  validate :check_image_size

  def check_image_size
    return unless image.blob.byte_size > 5.megabytes

    errors.add(:image, 'image should be less than 5MB')
    image.purge
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
