require "yaml"

cfg_path              =   File.join(File.dirname(__FILE__), "../../config/credentials.yml")

if ::File.exists?(cfg_path)
  cfg                 =   YAML.load_file(cfg_path)
  
  RSpec.configure do |config|
    config.before(:each) do
      ::Mailinabox::Api.configure do |config|
        config.host       =   cfg.fetch("host", nil)
        config.user       =   cfg.fetch("user", nil)
        config.password   =   cfg.fetch("password", nil)
      end
    end
  end
end
