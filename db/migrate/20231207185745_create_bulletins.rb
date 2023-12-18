# frozen_string_literal: true

class CreateBulletins < ActiveRecord::Migration[7.0]
  def change
    create_table :bulletins do |t|
      t.string :title, limit: 50, null: false
      t.string :description, limit: 1000, null: false
      t.string :image, limit: 3.megabytes, null: false
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
