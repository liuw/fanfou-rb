require 'net/http'
require 'rss/1.0'
require 'rss/2.0'


class Fanfou

  API_PATH = 'http://api.fanfou.com'
  FORMATS = [:html, :rss, :xml, :json]

  def initialize(l, p)
    @loginname = l
    @password  = p
  end

  def get_followers_ids(format=:json)
    return nil if not FORMATS.include?(format)
    get(API_PATH+'/followers/ids.'+format.to_s)
  end

  def get_friends_ids(format=:json)
    return nil if not FORMATS.include?(format)
    get(API_PATH+'/friends/ids.'+format.to_s)
  end

  def get_public_timeline(format=:rss)
    return nil if not FORMATS.include?(format)
    get(API_PATH+'/statuses/public_timeline.'+format.to_s)
  end

  def unfollow(uid)
    post(API_PATH+'/friendships/destroy.xml', {'id' => uid})
  end

  def follow(uid)
    post(API_PATH+'/friendships/create.xml', {'id'=>uid})
  end

  def is_friend?(uid)
  end

  private
  def post(path, params)
    return false if not path
    url = URI.parse(path)
    req = Net::HTTP::Post.new(url.path)
    req.basic_auth @loginname, @password
    req.set_form_data(params)
    response = Net::HTTP.new(url.host, url.port).start do |http|
      begin
        http.request(req)
      rescue
      end
    end
    case response
    when Net::HTTPSuccess, Net::HTTPRedirection then return true
    else return false
    end
  end

  def get(path)
    return nil if not path
    response = nil
    url = URI.parse(path)
    req = Net::HTTP::Get.new(url.path)
    req.basic_auth @loginname, @password
    response = Net::HTTP.new(url.host, url.port).start do |http|
      begin
        http.request(req)
      rescue
      end
    end
    response
  end

end

