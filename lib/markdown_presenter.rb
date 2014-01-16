#!/usr/bin/env ruby

require 'haml'
require 'kramdown'

def present title, content
  template = File.read(File.join(File.dirname(__FILE__), "../presenter.html.haml"))
  haml_engine = Haml::Engine.new(template)
  haml_engine.render(Object.new, {slides: content.split(/(?=<h1)/), title: title}) do |filename|
    File.read File.join(File.dirname(__FILE__), "../", filename)
  end
end

def content_of filename
  if filename.end_with? ".md"
    Kramdown::Document.new(File.read(filename)).to_html

  elsif filename.end_with? ".html"
    File.read(filename)

  else
    $stderr.puts "Format not supported: #{File.extname(filename)}"
    exit 1
  end
end

def process filename
  puts present(filename, content_of(filename))
end

process ARGV[0] if __FILE__ == $0
