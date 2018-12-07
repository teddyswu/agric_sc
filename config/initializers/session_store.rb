# Be sure to restart your server when you modify this file.
custom = YAML.load_file("config/customization.yml")
Rails.application.config.session_store :cookie_store, key: '_ugooz_session', domain: custom[:domain]