# db/seeds.rb
# frozen_string_literal: true

puts "🛠 Seed in progress..."

# === Helpers ===
def attach_member_photo(member, filename)
  path = Rails.root.join("app/assets/images/#{filename}")
  if File.exist?(path)
    unless member.photos.attached? && member.photos.any? { |p| p.filename.to_s == filename }
      member.photos.attach(
        io: File.open(path),
        filename: filename,
        content_type: "image/jpeg"
      )
      puts "   📎 Photo attachée: #{filename} pour #{member.pseudo}"
    end
  else
    puts "⚠️ Image manquante pour #{member.pseudo} (#{filename})"
  end
end

# === Seed Events ===
puts "🎉 Seeding Events..."
events_data = [
  {
    name: 'Bordeaux GeekFest',
    photo: 'BGF2025.jpg',
    localisation: 'Parc des Expositions de Bordeaux. Cr Jules Ladoumegue, 33300 Bordeaux',
    description: "Le Bordeaux Geekfest c’est 200 exposants, 14 espaces et un grand nombre d’animations !",
    start_date: '2025-05-24',
    end_date: '2025-05-25',
    url: 'https://www.bordeauxgeekfest.com/'
  },
  {
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
  }
]

events_data.each do |attrs|
  event = Event.find_or_initialize_by(name: attrs[:name])
  event.assign_attributes(attrs.except(:name))
  event.save!
  puts "   ✅ Event: #{event.name}"
end

# === Seed Admin User ===
puts "🛡️ Seeding Admin User..."
admin = User.find_or_initialize_by(email: ENV.fetch('ADMIN_EMAIL'))
if admin.new_record?
  admin.password = ENV.fetch('ADMIN_PASSWORD')
  admin.username = "Gar'ad"
  admin.admin    = true
  admin.save!
  puts "   ✅ Admin créé: #{admin.email}"
else
  puts "   🔄 Admin déjà existant: #{admin.email}"
end

# === Seed Admin Member ===
puts "🔧 Seeding Admin Member..."
admin_member = Member.find_or_initialize_by(user: admin)
admin_member.assign_attributes(
  pseudo: "Gar'ad",
  presentation: " Depuis une dizaine d'années, Gar'ad s'est trouvé une passion pour le cosplay : la création
                  de ses cosplays, l'interprétation des personnages mais surtout partager de bons moments avec
                  ses camarades cosplayeurs !",
  reseau_social: "",
  role: 'Nazgul',
)
admin_member.save!
attach_member_photo(admin_member, "gar'ad.jpg") if File.exist?(Rails.root.join("app/assets/images/gar'ad.jpg"))
# Affiche le pseudo ET l'email de l'admin pour confirmation
puts "   ✅ Admin Member upserted: #{admin_member.pseudo} (#{admin.email})"

# === Seed Regular Users & Members ===
puts "👥 Seeding Members & Users..."
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
    role: "Nazgul",
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
},
{
  email: ENV.fetch("ADIKA_EMAIL"),
  password: ENV.fetch("ADIKA_PASSWORD"),
  username: "Ad'ika Tran",
  pseudo: "Ad'ika Tran",
  presentation: <<~TEXT,
  Jeune Cosplayeuse qui a toujours envie d'en apprendre plus . Une bonne joie de vivre et
  sera toujours disponible pour discuter.
  TEXT
  reseau_social: '',
  role: 'Nazgul',
  photo_filename: "ad'ika tran.jpg"
},
# {
  #   email: ENV.fetch(""),
  #   password: ENV.fetch(""),
  #   username: "",
  #   pseudo: "",
  #   presentation: <<~TEXT,

  #   TEXT
  #   reseau_social: '',
  #   role: 'Nazgul',
  #   photo_filename: ".jpg"
  # },
  # {
  #   email: ENV.fetch(""),
  #   password: ENV.fetch(""),
  #   username: "",
  #   pseudo: "",
  #   presentation: <<~TEXT,

  #   TEXT
  #   reseau_social: '',
  #   role: 'Nazgul',
  #   photo_filename: ".jpg"
  # },

  # {
  #   email: ENV.fetch(""),
  #   password: ENV.fetch(""),
  #   username: "",
  #   pseudo: "",
  #   presentation: <<~TEXT,

  #   TEXT
  #   reseau_social: '',
  #   role: 'Nazgul',
  #   photo_filename: ".jpg"
  # },
]






members_data.each do |data|
  user = User.find_or_initialize_by(email: data[:email])
  if user.new_record?
    user.password = data[:password]
    user.username = data[:username]
    user.admin    = false
    user.save!
    puts "   ✅ User créé: #{user.email}"
  else
    puts "   🔄 User existant: #{user.email}"
  end

  member = Member.find_or_initialize_by(user: user)
  member.assign_attributes(
    pseudo: data[:pseudo],
    presentation: data[:presentation],
    reseau_social: data[:reseau_social],
    role: data[:role]
  )
  member.save!
  puts "   ✅ Member upserted: #{member.pseudo}"

  attach_member_photo(member, data[:photo_filename]) if data[:photo_filename].present?
end

puts "🎉 Seeding completed successfully!"
