module AutoMatch
  module Registrations
    module CreationService
      include BaseService

      def call(match, registrar, params)
        registration = nil

        match.transaction do
          registration = Registration.find_or_initialize_by(match: match)

          if registration.registered_at && Time.zone.now - registration.registered_at < 1.minute
            registration.errors.add(:base, 'Another registration for this match is pending')
            rollback!
          end

          registration.assign_attributes(params)
          registration.generate_tokens
          registration.registered_by = registrar
          registration.registered_at = Time.zone.now
          registration.home_team_confirmed_by = nil
          registration.away_team_confirmed_by = nil

          registration.save
        end

        # TODO: Check rcon

        registration
      end
    end
  end
end
