require_relative 'boot'

require 'csv' # these two requirements allow csv and excel import and export
require 'roo' #

require 'rails/all'

require 'carrierwave'                     # required for storage of files
require 'carrierwave/orm/activerecord'    # required to fix mount_uploader bug in controllers

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SheqActionApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
