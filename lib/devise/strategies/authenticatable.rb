require 'devise/strategies/base'

module Devise
  module Strategies
    # Default strategy for signing in a user, based on his email and password.
    # Redirects to sign_in page if it's not authenticated
    class Authenticatable < Base
      def valid?
        params[scope] && params[scope][:password].present? && mapping.to.respond_to?(:authenticate)
      end

      # Authenticate a user based on email and password params, returning to warden
      # success and the authenticated user if everything is okay. Otherwise redirect
      # to sign in page.
      def authenticate!
        if resource = mapping.to.authenticate(params[scope])
          success!(resource)
        else
          fail!(:invalid)
        end
      end
    end
  end
end

Warden::Strategies.add(:authenticatable, Devise::Strategies::Authenticatable)
