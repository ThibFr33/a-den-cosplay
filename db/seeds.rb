# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# frozen_string_literal: true

puts "🛠 Seed in progress..."

# === Helpers ===

def attach_member_photo(member, filename)
  path = Rails.root.join("app/assets/images/#{filename}")
  if File.exist?(path)
    member.photos.attach(
      io: File.open(path),
      filename: filename,
      content_type: "image/jpeg"
    )
  else
    puts "⚠️ Image manquante pour #{member.pseudo} (#{filename})"
  end
end

puts "⛔ Cleaning database..."

User.destroy_all
Member.destroy_all
Event.destroy_all

# === Create Events ===

puts "🎉 Seeding Events..."

Event.create!(
  name: 'Bordeaux GeekFest',
  photo: 'BGF2025.jpg',
  localisation: 'Parc des Expositions de Bordeaux. Cr Jules Ladoumegue, 33300 Bordeaux',
  description: "Le Bordeaux Geekfest c’est 200 exposants, 14 espaces et un grand nombre d’animations !",
  start_date: '2025-05-24',
  end_date: '2025-05-25',
  url: 'https://www.bordeauxgeekfest.com/'
)

Event.create!(
  name: 'Geek Days',
  photo: 'geek_days.jpg',
  localisation: 'Centre Culturel de Villeneuve-sur-Lot, 23 rue Etienne Marcel, 47300 Villeneuve-sur-Lot',
  description: <<~TEXT,
    Les Geek Days sont le rendez-vous incontesté des jeunes et des familles du territoire,
    leur permettant de se rencontrer autour d'une passion commune : les mangas, le gaming, le cosplay,
    et bien plus encore. Cet événement gratuit vise aussi à sensibiliser sur les dangers d'une utilisation excessive des écrans,
    tout en favorisant la mixité des publics.
  TEXT
  start_date: '2025-04-26',
  end_date: '2025-04-26',
  url: 'https://www.grand-villeneuvois.fr/geek-days-2-346.html'
)

# === Create Admin User ===

puts "🛡️ Creating Admin User..."

admin = User.create!(
  email: ENV.fetch('ADMIN_EMAIL'),
  password: ENV.fetch('ADMIN_PASSWORD'),
  username: "Gar'ad",
  admin: true
)

puts "✅ Admin created"

# === Create Regular Users and Members ===

puts "👥 Seeding Members Users..."

members_data = [
  {
    email: ENV.fetch("VOKSHA_EMAIL"),
    password: ENV.fetch("VOKSHA_PASSWORD"),
    username: "Vok'sha",
    pseudo: "Vok'sha",
    presentation: <<~TEXT,
      Cosplayer depuis déjà de nombreuses années, il a créé le clan il y a quelques mois et s'évertue à le
      renforcer et réunir tous les mandos de la galaxie Nouvelle-Aquitaine
    TEXT
    reseau_social: 'https://www.instagram.com/revan_shan33/',
    role: "Président",
    photo_filename: "vok'sha.jpg"
  },
  {
    email: ENV.fetch("BOBA_EMAIL"),
    password: ENV.fetch("BOBA_PASSWORD"),
    username: "Mando bobafett",
    pseudo: "Mando bobafett",
    presentation: <<~TEXT,
      Notre cosplayer 100% mandalorien pur souche à l'humour déjanté sera prêt à tout pour vous faire dire :
      "Boba Fett c'est le meilleur"
    TEXT
    reseau_social: 'https://www.instagram.com/mando.bobafett.cosplay/',
    role: '',
    photo_filename: 'booba_fett.jpg'
  },
  {
    email: ENV.fetch("OCA_EMAIL"),
    password: ENV.fetch("OCA_PASSWORD"),
    username: "Oca Skord",
    pseudo: "Oca Skord",
    presentation: <<~TEXT,
      Que serait Boba Fett sans sa partenaire Fennec. Christine incarne Fennec Shand avec élégance et
      précision, reproduisant chaque détail de son costume emblématique. Malgré sa nouveauté dans le milieu,
      elle impressionne par son authenticité et son dévouement.
    TEXT
    reseau_social: '',
    role: '',
    photo_filename: 'fennec_shand.jpg'
  },
  {
    email: ENV.fetch("BUIR_EMAIL"),
    password: ENV.fetch("BUIR_PASSWORD"),
    username: "Buir Burk'yc",
    pseudo: "Buir Burk'yc",
    presentation: <<~TEXT,
      Buir Burk'yc est un chasseur de primes mandalorien imposant et serein, alliant force et sagesse.
      Il excelle également dans la stratégie, un véritable atout pour le clan.
    TEXT
    reseau_social: '',
    role: '',
    photo_filename: "buir burk'yc.jpg"
  }
]

members_data.each do |data|
  user = User.create!(
    email: data[:email],
    password: data[:password],
    username: data[:username],
    admin: false
  )

  member = user.create_member!(
    pseudo: data[:pseudo],
    presentation: data[:presentation],
    reseau_social: data[:reseau_social],
    role: data[:role]
  )

  attach_member_photo(member, data[:photo_filename]) if data[:photo_filename].present?

  puts "✅ Member created: #{member.pseudo}"
end

puts "🎉 Seeding completed successfully!"
