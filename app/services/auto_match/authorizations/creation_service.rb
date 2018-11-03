module AutoMatch
  module Authorizations
    module CreationService
      include BaseService

      def call(registration)
        authorization = auth_from_reg(registration)

        authorization.transaction do
          authorization.save || rollback!

          registration.delete || rollback!
        end

        authorization
      end

      private

      def auth_from_reg(reg)
        Authorization.new(
          match_id: reg.match_id, registered_by_id: reg.registered_by_id,
          home_team_confirmed_by_id: reg.home_team_confirmed_by_id,
          away_team_confirmed_by_id: reg.away_team_confirmed_by_id,
          ip: reg.ip, port: reg.port, password: reg.password, token: reg.token, registered_at: reg.registered_at,
          confirmed_at: Time.zone.now)
      end
    end
  end
end
