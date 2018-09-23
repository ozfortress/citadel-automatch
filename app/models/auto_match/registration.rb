module AutoMatch
  class Registration < ApplicationRecord
    self.table_name = :auto_match_registrations

    before_validation :generate_token, on: :create

    belongs_to :match, class_name: 'League::Match'
    belongs_to :registered_by, class_name: 'User'

    validates :token, presence: true

    validate :validate_match_pending
    validate :validate_registration_timeout, on: :update

    after_validation do
      self.registered_at = Time.zone.now
    end

    def generate_token
      self.token = SecureRandom.hex(32)
    end

    private

    def validate_match_pending
      errors.add(:match, 'is not pending') unless match.pending?
    end

    def validate_registration_timeout
      if Time.zone.now - registered_at < 1.minute
        errors.add(:base, 'Another registration for this match is pending')
      end
    end
  end
end
