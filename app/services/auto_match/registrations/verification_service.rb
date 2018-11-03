require 'rcon/rcon'

module AutoMatch
  module Registrations
    module VerificationService
      include BaseService

      def call(registration, user)
        match = registration.match

        if match.home_team.on_roster?(user)
          registration.update!(home_team_confirmed_by: user)
        elsif match.away_team.on_roster?(user)
          registration.update!(away_team_confirmed_by: user)
        end

        # Testing only
        registration.update!(home_team_confirmed_by: user, away_team_confirmed_by: user)

        # Notify the server using rcon
        # TODO: Handle errors
        rcon = RCon::Query::Source.new(registration.ip, registration.port)
        rcon.auth(registration.password)
        if registration.ready?
          rcon.command('cas_confirmation_complete')
        else
          rcon.command('cas_confirmation_progress')
        end
      end
    end
  end
end
