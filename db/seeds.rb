# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create(
  email: 'admin@admin.com',
  password: 'qwerty'
)

data = []
i = 1

while i <= 5
  data.push({ 'name' => "Организатор #{i}", 'description' => "Ваш персональный проводник в мир знаний №#{i}" })
  i += 1
end

Organizer.create(
  data
)
