#!/usr/bin/env ruby

require 'haml'
require 'kramdown'
require 'nokogiri'
require 'open-uri'
require 'base64'
require 'mime/types'

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

def data_uri_for url
  begin
    response = open(url)
    encoded_image = Base64.encode64 response.read
    content_type = response.respond_to?(:meta) ? response.meta['content-type'] : MIME::Types.type_for(url[-3..url.size]).first.content_type
    "data:#{content_type};base64,#{encoded_image}"
  rescue
    $stderr.puts "WARNING: An exception occurred trying to construct a data URI. We will fall back to the original URL.", $!, $!.backtrace
    url
  end
end

def embed content
  doc = Nokogiri::HTML(content)
  tags_and_attributes = [['img', 'src'], ['link','href'], ['script', 'src']]
  tags_and_attributes.each do |tag_name, src|
    doc.css(tag_name).each do |tag|
      tag[src] = data_uri_for tag[src]
    end
  end
  doc.css("body").inner_html
end

def process filename
  puts present(filename, embed(content_of(filename)))
end

if __FILE__ == $0
  ($stderr.puts "Specify a filename in argument."; exit 1) if ARGV.empty?

  process ARGV[0] 
end
