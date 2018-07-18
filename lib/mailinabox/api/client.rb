module Mailinabox
  module Api
    
    class Client
      attr_accessor :configuration, :connection
    
      def initialize(configuration: ::Mailinabox::Api.configuration)
        self.configuration          =   configuration
        self.init_connection
      end
    
      include ::Mailinabox::Api::Endpoints::Users
    
      def init_connection(headers: {}, options: {})
        headers["User-Agent"]       =   options.fetch(:user_agent, self.configuration.faraday.fetch(:user_agent, nil))
      
        self.connection           ||=   ::Faraday.new(url: self.configuration.host) do |builder|
          builder.headers           =   headers
          
          builder.basic_auth(self.configuration.user, self.configuration.password)
          
          builder.request  :url_encoded
          builder.response :logger      if self.configuration.verbose_faraday?
          
          builder.adapter self.configuration.faraday.fetch(:adapter, :net_http)
        end
      end

      def get(path, params: {}, headers: {}, options: {})
        request path, method: :get, params: params, headers: headers, options: options
      end

      def post(path, params: {}, data: {}, headers: {}, options: {})
        request path, method: :post, params: params, data: data, headers: headers, options: options
      end

      def request(path, method: :get, params: {}, data: {}, headers: {}, options: {}, retries: 3)      
        response              =   nil
      
        begin
          response            =   case method
            when :get, :head, :options
              self.connection.send(method) do |request|
                request.url path
                request.params  =   params if params && !params.empty?
              end
            when :post, :put, :patch, :delete
              self.connection.send(method) do |request|
                request.url path
                request.body    =   data if data && !data.empty?
                request.params  =   params if params && !params.empty?
              end
          end
        rescue Faraday::TimeoutError, Faraday::ConnectionFailed => e
          retries -= 1
          retry if retries > 0
        end
      
        return response&.body
      end
      
      def evaluate_response(method, response)
        response&.to_s&.strip&.downcase&.eql?(Mailinabox::Api::Constants::RESPONSES[method])
      end
      
    end
  end
end
