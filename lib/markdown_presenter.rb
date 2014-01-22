#!/usr/bin/env ruby

require 'haml'
require 'kramdown'

def present title, content
  template = File.read(File.join(File.dirname(__FILE__), "../presenter.html.haml"))
  haml_engine = Haml::Engine.new(template)
  haml_engine.render(Object.new, {slides: content.split(/(?=<h1)/).reject {|s| s.chomp.empty?}, title: title}) do |filename|
    File.read File.join(File.dirname(__FILE__), "../", filename)
  end
end

def content_of filename
  if filename.end_with? ".md"
    document = Kramdown::Document.new(File.read(filename), parse_block_html: true, parse_span_html: true)
    document.to_html

  elsif filename.end_with? ".html"
    require 'nokogiri'
    doc = Nokogiri::HTML(File.read(filename))
    doc.search('body')[0].inner_html

  else
    $stderr.puts "Format not supported: #{File.extname(filename)}"
    exit 1
  end
end

def process filename
  puts present(filename, content_of(filename))
end

process ARGV[0] if __FILE__ == $0
