# frozen_string_literal: true

def generate_bulletin
  categories = Category.all
  admin = User.find_by(admin: true)
  image_data = Rails.root.join('test/fixtures/files/lamp.png').read
  bulletin = Bulletin.new(title: Faker::Commerce.product_name,
                          description: Faker::Lorem.paragraph(sentence_count: 3),
                          user: admin,
                          category: categories.sample)
  bulletin.image.attach(io: StringIO.new(image_data), filename: 'lamp', content_type: 'image/png')
  bulletin.save
end

10.times do
  generate_bulletin
end
