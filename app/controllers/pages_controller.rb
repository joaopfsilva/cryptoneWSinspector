class PagesController < ApplicationController

  def home
    puts "********"
    # client = Aws::S3::Client.new(region: CREDENTIALS['AWS_REGION'])
    # puts client
    s3 = Aws::S3::Resource.new(region: CREDENTIALS['AWS_REGION'], access_key_id: CREDENTIALS['AWS_ACCESS_KEY_ID'], secret_access_key: CREDENTIALS['AWS_SECRET_ACCESS_KEY'])
    puts s3
    puts CREDENTIALS['AWS_REGION'].class
    puts '====='
    @s3_objects = s3.bucket(CREDENTIALS['AWS_BUCKET']).objects

# s3 = Aws::S3::Resource.new(region: "your-region")

#get images url
# s3.bucket("bucket-name").object("key/for/object")@s3_objects.presigned_url("get", expires_in: 3600)

    # retrieve the objects
    
    #default path https://s3-eu-west-1.amazonaws.com/cryptonewsinpector/banner_img1.jpg

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
