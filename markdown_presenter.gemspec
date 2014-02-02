VERSION = '0.5.7'

Gem::Specification.new do |s|
  s.name        = 'markdown_presenter'
  s.homepage    = 'https://github.com/matstc/markdown_presenter'
  s.version     = VERSION
  s.date        = '2014-01-16'
  s.summary     = "Transforms a markdown file into an HTML presentation"
  s.description = "Transforms a markdown file into an HTML presentation"
  s.authors     = ["Matthieu Tanguay-Carel"]
  s.email       = "matthieutc@gmail.com"
  s.files       = ["lib/markdown_presenter.rb",
                   "css/uikit.almost-flat.min.css",
                   "js/uikit.min.js",
                   "js/jquery-1.10.2.min.js",
                   "presenter.html.haml"
                  ]
  s.license     = 'CC BY-NC 4.0'
  s.executables << "markdown_presenter"

  s.add_runtime_dependency "haml"
  s.add_runtime_dependency "kramdown"
  s.add_runtime_dependency "nokogiri"
  s.add_runtime_dependency "open-uri"
  s.add_runtime_dependency "mime-types"
end
