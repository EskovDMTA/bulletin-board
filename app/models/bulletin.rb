# frozen_string_literal: true

class Bulletin < ApplicationRecord
  belongs_to :user
  belongs_to :category

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
end
