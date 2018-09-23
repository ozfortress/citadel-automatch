module AutoMatch
  class Authorization < ApplicationRecord
    self.table_name = :auto_match_authorizations

    belongs_to :match, class_name: 'League::Match'
  end
end
