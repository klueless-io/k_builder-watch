# require '.builders/_initialize.rb'

$LOAD_PATH.unshift(File.join(Dir.pwd, '.builders'))
load 'x.rb'
puts 'fucit'
# load 'x.rb'
# puts JSON.pretty_generate(KBuilder.configuration.to_h)

# builder = KBuilder::BaseBuilder.init

# builder
#   .add_file('main.rb', template_file: 'class.rb', name: 'main')
#   .add_file('person.rb',
#     template_file: 'model.rb',
#     name: 'person',
#     fields: %i[first_name last_name])
#   .add_file('address.rb',
#     template_file: 'model.rb',
#     name: 'address',
#     fields: %i[street1 street2 post_code state])
#   .add_file('css/index.css',
#     template: '{{#each colors}} .{{.}} { color: {{.}} }  {{/each}}',
#     colors: %w[red blue green],
#     pretty: true)

#     # /Users/davidcruwys/dev/xxx-watch
#     # /Users/davidcruwys/dev/xxx-watch/basic.rb


# file = builder.target_file('main.rb')
# puts file
# puts File.exist?(file)
# system("code #{file}")
# puts 'basic'