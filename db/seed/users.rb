# frozen_string_literal: true

def generate_user(uid)
  return if User.any?

  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    provider: 'github',
    admin: true,
    uid:
  )
end

10.times.map { |uid| generate_user(uid) }
