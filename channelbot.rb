# frozen_string_literal: true

require './telegram_lib'
require 'rss'
require 'nokogiri'
require 'open-uri'

def rss_picture
  $pics = []
  url = 'https://www.pinterest.com/user/feed.rss'
  open(url) do |rss|
    feed = RSS::Parser.parse(rss)
    puts "Title: #{feed.channel.title}"
    feed.items.each do |item|
      parsed = Nokogiri::HTML.parse(item.description)
      tags = parsed.xpath('//img')
      images = tags.map { |t| t[:src] }
      $pics.push(images)
    end
  end
end

puts rss_picture

def picture_random(folder: '/picture/random_picture.jpg')
  random_picture_url = $pics.sample[0]
  puts random_picture_url
  open(random_picture_url) do |image|
    File.open('./picture/random_picture.jpg', 'wb') do |file|
      file.write(image.read)
    end
    puts folder
  end
end



bot = Telegram.new('TOKEN')
bot.send_photo('CHAT_ID', 'PHOTO')
