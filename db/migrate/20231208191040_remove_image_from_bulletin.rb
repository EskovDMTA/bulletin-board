# frozen_string_literal: true

class RemoveImageFromBulletin < ActiveRecord::Migration[7.0]
  def change
    remove_column :bulletins, :image, :binary
  end
end
