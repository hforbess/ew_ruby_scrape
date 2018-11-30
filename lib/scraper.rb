require 'nokogiri'
require 'httparty'

class Scraper

attr_accessor :parse_page, :safe_url

  def initialize(uri)
    url = "http://www.eastwindgifts.com/#{uri}"
    @safe_url = URI.parse(URI.encode(url, "[]")) 

  end 
  
  def get_ids
    doc = HTTParty.get( @safe_url )  
    parse_page ||= Nokogiri::HTML(doc)
    results = parse_page.css("#contents-table > tr > td > a" )
  end
  
end


