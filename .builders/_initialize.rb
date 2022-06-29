Handlebars::Helpers.configure do |config|
  config_file = File.join(Gem.loaded_specs['handlebars-helpers'].full_gem_path, '.handlebars_helpers.json')
  config.helper_config_file = config_file
end

KBuilder.reset
templates_ruby  = '~/dev/kgems/k_dsl/_/.template/ruby-cmdlet'
target_root     = '~/dev/kgems/k_builder-watch/'

KConfig.configure do |config|
  config.target_folders.add(:app      , target_root)

  config.template_folders.add(:global , File.join(templates_ruby , '.global_template'))
  # config.template_folders.add(:app    , File.join(template_root , '.app_template'))
end

