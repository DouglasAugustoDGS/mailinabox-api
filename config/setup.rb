# This is just a helper file to configure the client from a credentials file

require "yaml"

cfg_path              =   File.join(File.dirname(__FILE__), "credentials.yml")

if ::File.exists?(cfg_path)
  cfg                 =   YAML.load_file(cfg_path)

  ::Mailinabox::Api.configure do |config|
    config.host       =   cfg.fetch("host", nil)
    config.user       =   cfg.fetch("user", nil)
    config.password   =   cfg.fetch("password", nil)
  end
end
