module AutoMatch
  module Authorizations
    module SubmissionService
      include BaseService

      def call(match, authorization, params)
        match.transaction do
          match.assign_attributes(params)
          match.status = :confirmed
          match.save || rollback!

          authorization.update(token: nil) || rollback!
        end
      end
    end
  end
end
