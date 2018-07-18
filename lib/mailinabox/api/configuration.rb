module Mailinabox
  module Api
    class Configuration
      attr_accessor :host, :user, :password
      attr_accessor :faraday
    
      def initialize
        self.host             =   nil
        self.user             =   nil
        self.password         =   nil
                
        self.faraday          =   {
          adapter:    :net_http,
          user_agent: 'Mail-in-a-box Ruby API Client',
          verbose:    false
        }
      end
      
      def verbose_faraday?
        self.faraday.fetch(:verbose, false)
      end
    
    end
  end
end
