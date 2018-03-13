class AppConfig
  include Singleton

  def initialize
  	@app_config = YAML.load_file("config/config.yml")
  end

  def [](key)
    @app_config[Rails.env][key.to_s]
  end

end