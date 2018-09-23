module API
  module V1
    module AutoMatch
      class RegistrationSerializer < ActiveModel::Serializer
        include Rails.application.routes.url_helpers

        type :registration

        attributes :match_id, :token

        attribute :verify_url do
          auto_match_verify_url(id: object.match_id, token: object.token)
        end
      end
    end
  end
end
