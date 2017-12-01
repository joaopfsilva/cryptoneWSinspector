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

    limit = 10

    @btc_news = []
    page.search('.category-bitcoin a').each do |element|
      @btc_news << ({news: element.content, url: element.xpath('@href').to_s})
    end

    @eth_news = []
    page.search('.category-ethereum a').each do |element|
      @eth_news << ({news: element.content, url: element.xpath('@href').to_s})
    end

    @xrp_news = []
    page.search('.category-ripple a').each do |element|
      @xrp_news << ({news: element.content, url: element.xpath('@href').to_s})
    end

    @btc_news = @btc_news.first(limit)
    @eth_news = @eth_news.first(limit)
    @xrp_news = @xrp_news.first(limit)
  end
  
end
