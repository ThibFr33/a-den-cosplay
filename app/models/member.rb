class Member < ApplicationRecord
  has_many_attached :photos
  belongs_to :user
  accepts_nested_attributes_for :user
  validates :user_id, uniqueness: true
  validates :pseudo, uniqueness: true
  before_validation :normalize_reseau_social_url
  validate :reseau_social_must_be_http_url

  enum role: {
    president: "president",
    co_president: "co_president",
    tresorier: "tresorier",
    secretaire: "secretaire",
    webmaster: "webmaster",
    event_manager: "event_manager",
    member: "member",
    adherent: "adherent",
    guest: "guest"
  }, _suffix: true

  ROLE_LABELS = {
    president: "Président",
    co_president: "Co-Président",
    tresorier: "Trésorier",
    secretaire: "Secrétaire",
    webmaster: "Webmaster",
    event_manager: "Responsable évènementiel",
    member: "Membre",
    adherent: "Adhérent",
    guest: "Invité d'honneur"
  }.freeze

  # Rôles à mettre en avant (bureau)
  BUREAU_ROLES = %w[
    president
    co_president
    tresorier
    secretaire
    webmaster
    event_manager
  ].freeze

  # Ordre d'affichage du bureau
  BUREAU_ORDER = BUREAU_ROLES

  scope :bureau, -> { where(role: BUREAU_ROLES) }
  scope :non_bureau, -> { where.not(role: BUREAU_ROLES) }

  scope :bureau_ordered, -> {
    where(role: BUREAU_ORDER).order(
      Arel.sql(
        "CASE role " \
        + BUREAU_ORDER.each_with_index.map { |r, i| "WHEN '#{r}' THEN #{i}" }.join(" ") \
        + " END"
      )
    )
  }

  validates :role, presence: true
  before_save :capitalize_pseudo

  # Pour le select dans les vues
  def self.roles_for_select
    roles.keys.map { |r| [ROLE_LABELS[r.to_sym], r] }
  end

  # Pour afficher le rôle proprement
  def role_label
    ROLE_LABELS[role.to_sym]
  end

  private

  def capitalize_pseudo
    return if pseudo.blank?

    self.pseudo = pseudo
      .downcase
      .gsub(/(^|[ \-])([a-zà-ÿ])/i) { "#{$1}#{$2.upcase}" }
  end

  def normalize_reseau_social_url
    return if reseau_social.blank?

    self.reseau_social = reseau_social.strip
    self.reseau_social = self.reseau_social.delete(" ")


    # si l'utilisateur colle "instagram.com/..." sans scheme
    unless reseau_social.match?(/\Ahttps?:\/\//i)
      self.reseau_social = "https://#{reseau_social}"
    end
  end

  def reseau_social_must_be_http_url
      return if reseau_social.blank?

      uri = URI.parse(reseau_social) rescue nil

      ok = uri&.is_a?(URI::HTTP) && uri.host.present?
      errors.add(:reseau_social, "doit être une URL http(s) valide") unless ok
  end
end
