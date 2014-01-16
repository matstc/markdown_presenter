Gem::Specification.new do |s|
  s.name        = 'markdown_presenter'
  s.homepage    = 'https://github.com/matstc/markdown_presenter'
  s.version     = '0.4.0'
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
end
