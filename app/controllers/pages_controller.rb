class PagesController < ApplicationController
  def home
  	require 'open-uri'
  	url  = "http://cryptone.ws"
	page = Nokogiri::HTML(open(url))
	@tweets = []
	page.search('.ctf-tweets div.ctf-tweet-content p').each do |element|
    	content = element.content
    	content_split = content.split("https")
    	@tweets << ({tweet: content_split.first, url: content_split.length > 1 ? "https" + content_split.last : ''})
   	end
  end
end
