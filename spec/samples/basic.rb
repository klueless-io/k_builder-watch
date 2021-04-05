
# usecases_folder = File.join(Dir.getwd, 'spec', 'usecases')

Handlebars::Helpers.configure do |config|
  config_file = File.join(Gem.loaded_specs['handlebars-helpers'].full_gem_path, '.handlebars_helpers.json')
  string_config_file = File.join(Gem.loaded_specs['handlebars-helpers'].full_gem_path, '.handlebars_string_formatters.json')
  # puts string_formatter_config_file

  config.helper_config_file = config_file
  config.string_formatter_config_file = string_config_file
end

KBuilder.reset

template_root   = '/Users/davidcruwys/dev/kgems/k_builder/spec/usecases'
target_root     = '/Users/davidcruwys/dev/kgems/k_builder-watch/spec/samples-output'

KBuilder.configure do |config|
  config.target_folders.add(:app      , target_root)

  config.template_folders.add(:global , File.join(template_root , '.global_template'))
  config.template_folders.add(:app    , File.join(template_root , '.app_template'))
end

# puts JSON.pretty_generate(KBuilder.configuration.to_h)

builder = KBuilder::BaseBuilder.init

builder
  .add_file('main.rb', template_file: 'class.rb', name: 'main')
  .add_file('person.rb',
    template_file: 'model.rb',
    name: 'person',
    fields: %i[first_name last_name])
  .add_file('address.rb',
    template_file: 'model.rb',
    name: 'address',
    fields: %i[street1 street2 post_code state])
  .add_file('css/index.css',
    template: '{{#each colors}} .{{.}} { color: {{.}} }  {{/each}}',
    colors: %w[red blue green],
    pretty: true)



# file = builder.target_file('main.rb')
# puts file
# puts File.exist?(file)
# system("code #{file}")
# puts 'basic'