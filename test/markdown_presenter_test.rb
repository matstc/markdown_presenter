require 'minitest/spec'
require 'minitest/autorun'
require_relative '../lib/markdown_presenter'


describe "MarkdownPresenter" do
  def setup_response_with &block
    MarkdownPresenter.class.send(:define_method, "open") do |url|
      block.yield
    end
  end

  it "falls back to original URL if it cannot fetch the file" do
    setup_response_with {raise "this is an error raised willingly in a test"}

    data_uri = MarkdownPresenter::data_uri_for "http://unreachable654987.io/image.png"
    data_uri.must_equal "http://unreachable654987.io/image.png"
  end

  it 'encodes a url into a data uri' do
    setup_response_with {
      Struct.new(:read) do
        def read
          "test content"
        end
      end.new
    }

    path = '/fairyland/test-file.txt'
    data_uri = MarkdownPresenter::data_uri_for "file://#{path}"
    data_uri.must_equal "data:text/plain;base64,dGVzdCBjb250ZW50\n"
  end
end
