# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Seed in progress"
Member.destroy_all
Member.create(
  { pseudo: "Vok'sha",
    presentation: "Cosplayer depuis déjà de nombreuses années, il a crée le clan il y a quelques mois et s'évertue à le
    renforcer et réunir tous les mandos de la galaxie Nouvelle-Aquitaine",
    reseau_social: "https://www.instagram.com/revan_shan33/",
    photos: 'revan.png'
  })
Member.create(
  { pseudo: 'mando.bobafett.cosplay',
    presentation: "Notre cosplayer 100% mandalorien pur souche à l'humour déjanté sera prêt à tout pour vous faire dire: Boba Fett c'est le meilleur",
    reseau_social: "https://www.instagram.com/mando.bobafett.cosplay/",
    photos: 'booba_fett.png'

  }
  )
puts "Seed finished"
