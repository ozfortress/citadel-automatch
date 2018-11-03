module AutoMatch
  class Registration < ApplicationRecord
    self.table_name = :auto_match_registrations

    before_validation :generate_tokens, on: :create

    belongs_to :match, class_name: 'League::Match'
    belongs_to :registered_by, class_name: 'User'
    belongs_to :home_team_confirmed_by, class_name: 'User', optional: true
    belongs_to :away_team_confirmed_by, class_name: 'User', optional: true

    validates :ip, presence: true
    validates :port, presence: true
    validates :password, length: { minimum: 0, allow_nil: false }

    validates :token, presence: true

    validate :validate_match_pending
    validate :validate_no_authorization, on: :create

    def generate_tokens
      self.token = SecureRandom.hex(64)
      self.user_token = SecureRandom.hex(32)
    end

    def ready?
      home_team_confirmed? && away_team_confirmed?
    end

    def home_team_confirmed?
      home_team_confirmed_by_id.present?
    end

    def away_team_confirmed?
      away_team_confirmed_by_id.present?
    end

    private

    def validate_match_pending
      errors.add(:match, 'is not pending') unless match.pending?
    end

    def validate_no_authorization
      if Authorization.exists?(match_id: match_id)
        errors.add(:base, 'Another server has already been authorized for this match')
      end
    end
  end
end
