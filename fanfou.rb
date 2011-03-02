require 'net/http'
require 'rss/1.0'
require 'rss/2.0'

class Fanfou

  API_PATH = 'http://api.fanfou.com'

  def initialize(l, p)
    @loginname = l
    @password  = p
  end

  def get_followers_ids_xml
    response = nil
    url = URI.parse(API_PATH)
    Net::HTTP.start(url.host, url.port) do |http|
      req = Net::HTTP::Get.new('/followers/ids.xml')
      req.basic_auth @loginname, @password
      begin
        response = http.request(req)
      rescue
      end
    end
    response
  end

  def get_followers_ids_json
    response = nil
    url = URI.parse(API_PATH)
    Net::HTTP.start(url.host, url.port) do |http|
      req = Net::HTTP::Get.new('/followers/ids.json')
      req.basic_auth @loginname, @password
      begin
        response = http.request(req)
      rescue
      end
    end
    response
  end

  def get_friends_ids_xml
    response = nil
    url = URI.parse(API_PATH)
    Net::HTTP.start(url.host, url.port) do |http|
      req = Net::HTTP::Get.new('/friends/ids.xml')
      req.basic_auth @loginname, @password
      begin
        response = http.request(req)
      rescue
      end
    end
    response
  end

  def get_friends_ids_json
    response = nil
    url = URI.parse(API_PATH)
    Net::HTTP.start(url.host, url.port) do |http|
      req = Net::HTTP::Get.new('/friends/ids.json')
      req.basic_auth @loginname, @password
      begin
        response = http.request(req)
      rescue
      end
    end
    response
  end

  def get_public_timeline
    response = nil
    url = URI.parse(API_PATH)
    Net::HTTP.start(url.host, url.port) do |http|
      req = Net::HTTP::Get.new('/statuses/public_timeline.rss')
      req.basic_auth @loginname, @password
      begin
        response = http.request(req)
      rescue
      end
    end
    response
  end

  def unfollow(uid)
    url = URI.parse(API_PATH+'/friendships/destroy.xml')
    req = Net::HTTP::Post.new(url.path)
    req.basic_auth @loginname, @password
    req.set_form_data({'id' => uid})

    response = Net::HTTP.new(url.host, url.port).start {|http| http.request(req)}
    case response
    when Net::HTTPSuccess, Net::HTTPRedirection
      return true
    else
      return false
    end

  end

  def follow(uid)
    url = URI.parse(API_PATH+'/friendships/create.xml')
    req = Net::HTTP::Post.new(url.path)
    req.basic_auth @loginname, @password
    req.set_form_data({'id' => uid})

    response = Net::HTTP.new(url.host, url.port).start {|http| http.request(req)}
    case response
    when Net::HTTPSuccess, Net::HTTPRedirection
      return true
    else
      return false
    end
  end

  def is_friend?(uid)
  end

end

