require 'net/ldap'
require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class LdapAuthenticatable < Authenticatable
      def authenticate!
        if params[:user]
          ldap = Net::LDAP.new
	  ldap.host = 'DOMAIN_CONTROLLER'
	  ldap.port = 389
          ldap.auth email, password
        
          if ldap.bind
		  if User.exists?(email: email)
			  user = User.find(email: email)
		  else
			  user = User.create(email: email, password: password, reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 4, current_sign_in_at: "2014-12-30 23:41:54", last_sign_in_at: "2014-12-30 23:40:40", current_sign_in_ip: "::1", last_sign_in_ip: "::1", role: 2)
		  end
  	          success!(user)
          else
            return fail(:invalid_login)
          end
        end
      end
      
      def email
        params[:user][:email]
      end

      def password
        params[:user][:password]
      end

    end
  end
end

Warden::Strategies.add(:ldap_authenticatable, Devise::Strategies::LdapAuthenticatable)
