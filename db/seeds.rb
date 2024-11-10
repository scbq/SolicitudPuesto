# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

# Elimina ofertas anteriores si es necesario
JobOffer.destroy_all

# Crea 10 ofertas de empleo ficticias
10.times do
  JobOffer.create!(
    title: Faker::Job.title,
    description: Faker::Lorem.paragraph,
    user: User.find_by(email: 'esteban@example.com') # Asegura que Esteban sea el creador
  )
end

puts "Se han creado 10 ofertas de empleo ficticias."
