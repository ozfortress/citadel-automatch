module API
  module V1
    module AutoMatch
      class AuthorizationSerializer < ActiveModel::Serializer
        type :authorization

        attributes :match_id, :token
      end
    end
  end
end
