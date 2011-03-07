require 'net/http'
require 'json'

module Fanfou
  API_PATH = 'http://api.fanfou.com/'
  FORMATS = [:xml, :json]
  API = {
    :public_timeline => API_PATH+"statuses/public_timeline",
    :friends_timeline => API_PATH+"statuses/friends_timeline",
    :exists => API_PATH+"friendships/exists",
    :replies => API_PATH+"statuses/replies",
    :mentions => API_PATH+"statuses/mentions",
    :show => API_PATH+"users/show",
    :test => API_PATH+"help/test",
    :user_timeline => API_PATH+"statuses  /user_timeline",
    :update => API_PATH+"statuses/update",
    :destroy => API_PATH+"statuses/destroy",
    #photo related
    :photos_upload => API_PATH+"photos/upload",
    #search
    :search_public_timeline => API_PATH+"search/public_timeline",
    :trends => API_PATH+"trends",
    :users_friends => API_PATH+"users/friends",
    :users_followers => API_PATH+"users/followers",
    :users_show => API_PATH+"users/show",
    #private msg
    :direct_messages => API_PATH+"direct_messages",
    :direct_messages_sent => API_PATH+"direct_messages/sent",
    :direct_messages_new => API_PATH+"direct_messages/new",
    :direct_messages_destroy => API_PATH+"direct_messages/destroy",
    #favorites related
    :favorites => API_PATH+"favorites",
    :favorites_create_id => API_PATH+"favorites/create/id",
    :favorites_destroy => API_PATH+"favorites/destroy/id",
    #friends
    :friendships_create => API_PATH+"friendships/create",
    :friendships_destroy => API_PATH+"friendships/destroy",
    :friendships_exists => API_PATH+"friendships/exists",
    :friends_ids => API_PATH+"friends/ids",
    :followers_ids => API_PATH+"followers/ids",
    #notification
    :notifications_follow => API_PATH+"notifications/follow",
    :notifications_leave => API_PATH+"notifications/leave",
    #Blacklist
    :blocks_create => API_PATH+"blocks/create",
    :blocks_destroy => API_PATH+"blocks/destroy",
    #account
    :account_verify_credentials => API_PATH+"account/verify_credentials",
    #search
    :saved_searches => API_PATH+"saved_searches",
    :saved_searches_show_id => API_PATH+"saved_searches/show/id",
    :saved_searches_create => API_PATH+"saved_searches/create",
    :saved_searches_destroy => API_PATH+"saved_searches/destroy/id"
  }

  class Fanfou

    def initialize(l, p)
      @loginname = l
      @password  = p
    end

    def get_followers_ids(format=:json)
      return nil if not FORMATS.include?(format)
      get(API_PATH+'followers/ids.'+format.to_s)
    end

    def get_friends_ids(format=:json)
      return nil if not FORMATS.include?(format)
      get(API_PATH+'friends/ids.'+format.to_s)
    end

    def get_public_timeline(count=20, format=:json)
      return nil if not FORMATS.include?(format)
      params = {'count'=>count}
      get(API[:public_timeline]+'.'+format.to_s, params)
    end

    def friendships_create(uid)
      post(API[:friendships_create]+'.json', {'id' => uid})
    end

    def friendships_destroy(uid)
      post(API[:friendships_destroy]+'.json', {'id' => uid})
    end

    def unfollow(uid)
      friendships_destroy(uid)
    end

    def follow(uid)
      friendships_create(uid)
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

    def get(path, params)
      return nil if not path
      response = nil
      str_params = "?".concat(params.collect{|k,v| "#{k}=#{v.to_s}"}.join("&"))
      url = URI.parse(path)
      req = Net::HTTP::Get.new(url.path+str_params)
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

end
