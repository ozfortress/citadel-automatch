module AutoMatch
  module Registrations
    module CreationService
      include BaseService

      def call(match, registrar)
        registration = nil

        match.transaction do
          registration = Registration.find_or_initialize_by(match: match)

          registration.generate_token
          registration.registered_by = registrar
          registration.save
        end

        registration
      end
    end
  end
end
