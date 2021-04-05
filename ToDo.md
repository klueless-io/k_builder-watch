# ToDo today

- Watch
  - CLI - Unit Test
  - Add create new builder
    - Touch and code for now
    - Later on it can create from template

- domains: KafeOwner.com (KafeManager.com)
- New csharp solution
  - KafeOwner
    - kw -t csharp -n KafeOwner
      - Creates a folder called KafeOwner and then a folder called .builders
    - kw -n csharp
      - Creates a folder called .builders and touches setup.rb

- 11:30 Go see Ken (Move Car)
- 2pm Go See Angus
  - Take some receipts
- 12pm Go to Council and get a new permit



Tonight:

- GPT3 Experiments across the cafe segmentation's
- CLI - Unit Test

- Call Chris









I figured out the issue was environmental and that got me looking up a line of code that was generated automatically in the `bin/console` file in my GEM.

The line of code was `require 'bundler/setup'` which I had often seen but never understood it's purpose [Bundler Setup](https://bundler.io/guides/bundler_setup.html).

I added that line of code to my `exe/k_builder-watch` file and now the local GEM dependencies are being loaded via the Gemfile.

```ruby
#!/usr/bin/env ruby

# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../lib'))

# LINE to ADD
require 'bundler/setup' # <-- ADD THIS LINE

require 'k_builder/watch'

cli = KBuilder::Watch::Cli.new
cli.execute

watcher = KBuilder::Watch::Watcher.new(cli.watch_path)
watcher.start
```

[![Local Dependencies][1]][1]


  [1]: https://i.stack.imgur.com/KQeAb.png