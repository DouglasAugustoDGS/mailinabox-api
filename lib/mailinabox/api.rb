# Gems
require "faraday"
require "faraday_middleware"

# Standard Lib
require "json"

require "mailinabox/api/version"

require "mailinabox/api/constants"

require "mailinabox/api/configuration"

require "mailinabox/api/endpoints/users"

require "mailinabox/api/client"

module Mailinabox
  module Api
    
    class << self
      attr_writer :configuration
    end
  
    def self.configuration
      @configuration ||= ::Mailinabox::Api::Configuration.new
    end

    def self.reset
      @configuration = ::Mailinabox::Api::Configuration.new
    end

    def self.configure
      yield(configuration)
    end
    
  end
end
