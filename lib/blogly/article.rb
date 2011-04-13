require 'rdiscount'

# Header regex (non-tested): /^(\#+[^\n]+|\n\n[^\n]+\n[\-\=]+[^\n]+)/ ?

module Blogly
  class Article

    attr_accessor :filepath, :filename
    attr_accessor :posted_at
    attr_accessor :title, :url
    attr_accessor :html

    def self.from_file(path)
      @filepath = path
      @filename = path.split('/').last
      
      # Get posted at date/time based on filename bits
      filename_bits = @filename.split('.')
      url = "/#{filename_bits[0].gsub(/\-/, '/')}/#{filename_bits[2]}"
      posted_at = DateTime.strptime("#{filename_bits[0]} #{filename_bits[1]}", '%Y-%m-%d %H%M') rescue nil

      markdown = File.read(@filepath)
      Article.new(markdown, :url => url, :posted_at => posted_at)
    end

    def initialize(markdown, attributes = {})
      attributes.each_pair do |key, val|
        self.send "#{key}=", val
      end

      @html = RDiscount.new(markdown).to_html
      @title = @html.slice!(/^<h\d>[^<]*<\/h\d>/).strip_tags
    end

  end
end