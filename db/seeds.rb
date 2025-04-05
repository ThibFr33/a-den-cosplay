# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts 'Seed in progress'
Member.destroy_all
Event.destroy_all
Member.create(
  { pseudo: "Vok'sha",
    presentation: "Cosplayer depuis déjà de nombreuses années, il a crée le clan il y a quelques mois et s'évertue à le
    renforcer et réunir tous les mandos de la galaxie Nouvelle-Aquitaine",
    reseau_social: 'https://www.instagram.com/revan_shan33/',
    photos: "vok'sha.png" }
)
Member.create(
  { pseudo: 'Mando.bobafett',
    presentation: "Notre cosplayer 100% mandalorien pur souche à l'humour déjanté sera prêt à tout pour vous faire dire:
    Boba Fett c'est le meilleur",
    reseau_social: 'https://www.instagram.com/mando.bobafett.cosplay/',
    photos: 'booba_fett.png' }
  )
Member.create(
  { pseudo: 'Oca Skord',
    presentation: 'Que serait Boba Fett sans sa partenaire Fennec. Christine incarne Fennec Shand avec élégance et
    précision, reproduisant chaque détail de son costume emblématique. Malgré sa nouveauté dans le milieu, elle
    impressionne par son authenticité et son dévouement',
    reseau_social: '',
    photos: 'fennec_shand.png' }
)
Member.create(
  { pseudo: "Buir Burk'yc",
    presentation: "Buir Burk'yc est un chasseur de primes mandalorien imposant et serein, alliant force et sagesse.
    Il excelle également dans la stratégie, un véritable atout pour le clan.",
    reseau_social: '',
    photos: "buir burk'yc.png" }
)
Event.create(
  { name: 'Bordeaux GeekFest',
    photo: 'BGF2025.png',
    localisation: 'Parc des Expositions de Bordeaux. Cr Jules Ladoumegue, 33300 Bordeaux',
    description: "Le Bordeaux Geekfest c’est 200 exposants, 14 espaces et un grand nombre d’animations !",
    start_date: '24/05/2025',
    end_date: '25/02/2025',
    url: 'https://www.bordeauxgeekfest.com/' }
)
Event.create(
  { name: 'Geek Days',
    photo: 'geek_days.png',
    localisation: 'Centre Culturel de Villeneuve-sur-Lot, 23 rue Etienne Marcel, 47300 Villeneuve-sur-Lot',
    description: "Les Geek Days sont le rendez-vous incontesté des jeunes et des familles du territoire,
    leur permettant de se rencontrer autour d'une passion commune : les mangas, le gaming, le cosplay,
    et bien plus encore. Cet événement gratuit vise non seulement à célébrer la culture geek, mais aussi
    à sensibiliser sur les dangers d'une utilisation excessive des écrans, tout en favorisant la mixité
    des publics et en animant nos territoires ruraux demandeurs d’activités culturelles.",
    start_date: '26/04/2025',
    end_date: '26/04/2025',
    url: 'https://www.grand-villeneuvois.fr/geek-days-2-346.html' }
)
Event.create(
  { name: 'Barbec chez François et Christine',
    photo: 'Francois.jpg',
    localisation: 'Mios',
    description: 'Après missa cuisant échec du raid sur Jabba palais, missa ordonne repli stratégique dans le jardin a
    noussa pour méga fiesta',
    start_date: '06/04/2025',
    end_date: '06/04/2025',
    url: 'https://starwars.fandom.com/wiki/Boba_Fett' }
)
puts 'Seed finished'
