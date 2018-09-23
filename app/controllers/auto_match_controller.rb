class AutoMatchController < ApplicationController
  before_action do
    @registration = AutoMatch::Registration.find_by(match_id: params[:id], token: params[:token])
    @match = @registration.match
    @league = @match.league
  end

  def show
  end

  def verify
  end
end
