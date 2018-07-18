module Mailinabox
  module Api
    module Endpoints
      module Users
      
        def users(domain: nil, options: {})
          params      =   {
            format: :json
          }
        
          response    =   get("/admin/mail/users", params: params, options: options)
          response    =   !response.to_s.empty? ? JSON.parse(response) : response
          response    =   response.select { |data| data["domain"].eql?(domain) }.first if !domain.to_s.empty? && (response && response.is_a?(Array) && response.any?)
          
          return response
        end
        
        def add_user(email:, password:, options: {})
          data        =   {
            email:      email,
            password:   password,
          }
          
          evaluate_response(__method__, post("/admin/mail/users/add", data: data, options: options))
        end
        
        def remove_user(email:, options: {})
          data        =   {
            email:      email,
          }
          
          evaluate_response(__method__, post("/admin/mail/users/remove", data: data, options: options))
        end
        
        def add_user_privilege(email:, privilege: :admin, options: {})
          data        =   {
            email:      email,
            privilege:  privilege,
          }
          
          evaluate_response(__method__, post("/admin/mail/users/privileges/add", data: data, options: options))
        end
        
        def remove_user_privilege(email:, privilege: :admin, options: {})
          data        =   {
            email:      email,
            privilege:  privilege,
          }
          
          evaluate_response(__method__, post("/admin/mail/users/privileges/remove", data: data, options: options))
        end
        
      end
    end
  end
end
