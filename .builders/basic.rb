require '_initialize.rb'

builder = KBuilder::BaseBuilder
  .init
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

puts 'DONE!'