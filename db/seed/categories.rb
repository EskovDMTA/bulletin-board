# frozen_string_literal: true

category_name = [
  'Личные вещи',
  'Транспорт',
  'Работа',
  'Для дома и дачи',
  'Недвижимость',
  'Хобби и отдых',
  'Электроника',
  'Животные'
]

def create_category(category_name)
  return if Category.any?

  category_name.map { |name| Category.create(name:) }
end

create_category(category_name)
