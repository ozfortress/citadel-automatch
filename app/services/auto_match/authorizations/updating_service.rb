module AutoMatch
  module Authorizations
    module UpdatingService
      include BaseService

      def call(match, authorization, params)
        match.transaction do
          match.update(params) || rollback!
        end
      end
    end
  end
end
