require 'byebug'

module API
  module V1
    module AutoMatch
      class Controller < APIController
        skip_before_action :authenticate, only: [:find, :register, :submit]

        before_action only: [:update, :submit] do
          @authorization = League::Match.find_by(match_id: params[:id], token: params[:token])
        end

        def find
          user = User.find_by(steam_id: params[:invoker])
          player_ids = Set.new params[:players].map(&:to_i)

          matches = user.matches.includes(home_team: [players: :user], away_team: [players: :user]).to_a
          matches = matches.select do |match|
            players = match.home_team.players + match.away_team.players
            present_count = players.count { |player| player_ids.include? player.user.steam_id }

            # present_count > player_ids.length / 2
            true
          end

          render json: matches, each_serializer: Leagues::MatchSerializer
        end

        def register
          match = League::Match.find(params[:id])
          user = User.find_by(steam_id: params[:invoker])

          registration = ::AutoMatch::Registrations::CreationService.call(match, user)

          if registration.errors.any?
            render_error :bad_request, errors: registration.errors.full_messages
          else
            render json: registration, serializer: RegistrationSerializer
          end
        end

        def update
          ::AutoMatch::Authorizations::UpdateService.call(@authorization, params)

          if @authorization.errors.any?
            render_error :bad_request, errors: @authorization.errors.full_messages
          else
            render json: {}
          end
        end

        def submit
          ::AutoMatch::Authorizations::SubmissionService.call(@authorization, params)

          if @authorization.errors.any?
            render_error :bad_request, errors: @authorization.errors.full_messages
          else
            render json: {}
          end
        end
      end
    end
  end
end
