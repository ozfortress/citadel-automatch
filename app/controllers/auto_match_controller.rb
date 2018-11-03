class AutoMatchController < ApplicationController
  def show
    @token = params[:token]
    # Do this to avoid a race condition
    AutoMatch::Registration.transaction do
      @registration = AutoMatch::Registration.find_by(match_id: params[:id], user_token: @token)
      @authorization = AutoMatch::Authorization.find_by(match_id: params[:id])
      @match = (@registration || @authorization).match
    end
    @league = @match.league

    @for_home_team = @match.home_team.on_roster?(current_user)
    @for_away_team = @match.away_team.on_roster?(current_user)
  end

  def verify
    @token = params[:token]
    @registration = AutoMatch::Registration.find_by(match_id: params[:id], user_token: @token)
    AutoMatch::Registrations::VerificationService.call(@registration, current_user)

    redirect_to auto_match_verify_path(id: params[:id], user_token: @token)
  end
end
