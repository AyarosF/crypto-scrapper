require 'rubygems'
require 'nokogiri'
require 'open-uri'

class StartScrap

  def initialize
    @site = Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/'))
  end

  def all_the_names
    @site.css('a.currency-name-container')
  end

  def all_the_prices
    @site.css('a.price')
  end

  def data_in_hash(array1, array2)
    name_array = []
    price_array = []
    for i in (0...50) do
      name_array << array1[i].text
      price_array << array2[i].text
    end
    @crypto = Hash[name_array.zip(price_array)]
  end

  def save
    Crypto.delete_all
    @crypto.each do |k, v|
      Crypto.create(
      name: k,
      rate: v
    )
    end
  end

  def perform
    data_in_hash(all_the_names, all_the_prices)
    save
  end
end
