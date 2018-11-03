module AutoMatch
  class Authorization < ApplicationRecord
    self.table_name = :auto_match_authorizations

    belongs_to :match, class_name: 'League::Match'
    belongs_to :registered_by, class_name: 'User'
    belongs_to :home_team_confirmed_by, class_name: 'User'
    belongs_to :away_team_confirmed_by, class_name: 'User'

    validates :ip, presence: true
    validates :port, presence: true
    validates :password, length: { minimum: 0, allow_nil: false }

    scope :active, -> { where.not(token: nil) }
  end
end
