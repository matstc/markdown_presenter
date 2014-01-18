#!/usr/bin/env ruby
load 'markdown_presenter.gemspec'

puts `gem build markdown_presenter.gemspec`
puts `gem install markdown_presenter-#{VERSION}.gem`
puts `echo '# Header One\n\nContent\n\n# Header Two\n\nContent too\n\n# Header Three\n\nContent tree' > /tmp/test.md`
puts `markdown_presenter /tmp/test.md > /tmp/test.html`

html = File.read('/tmp/test.html')

(puts html; raise "resulting html seems to be invalid") unless html.end_with? "</html>\n"

puts "The gem looks good. Feel free to push it like so:\n\ngem push markdown_presenter-#{VERSION}.gem"
puts
