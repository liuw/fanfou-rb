require 'net/http'
require 'json'

module Fanfou
  API_PATH = 'http://api.fanfou.com/'
  EXT = '.json'
  FORMATS = [:xml, :json, :html]
  API = {
    :public_timeline => API_PATH+"statuses/public_timeline"+EXT,
    :friends_timeline => API_PATH+"statuses/friends_timeline"+EXT,
    :exists => API_PATH+"friendships/exists"+EXT,
    :replies => API_PATH+"statuses/replies"+EXT,
    :mentions => API_PATH+"statuses/mentions"+EXT,
    :show => API_PATH+"users/show"+EXT,
    :test => API_PATH+"help/test"+EXT,
    :user_timeline => API_PATH+"statuses/user_timeline"+EXT,
    :update => API_PATH+"statuses/update"+EXT,
    :destroy => API_PATH+"statuses/destroy"+EXT,
    #photo related
    :photos_upload => API_PATH+"photos/upload"+EXT,
    #search
    :search_public_timeline => API_PATH+"search/public_timeline"+EXT,
    :trends => API_PATH+"trends"+EXT,
    :users_friends => API_PATH+"users/friends"+EXT,
    :users_followers => API_PATH+"users/followers"+EXT,
    :users_show => API_PATH+"users/show"+EXT,
    #private msg
    :direct_messages => API_PATH+"direct_messages"+EXT,
    :direct_messages_sent => API_PATH+"direct_messages/sent"+EXT,
    :direct_messages_new => API_PATH+"direct_messages/new"+EXT,
    :direct_messages_destroy => API_PATH+"direct_messages/destroy"+EXT,
    #favorites related
    :favorites => API_PATH+"favorites"+EXT,
    :favorites_create => API_PATH+"favorites/create/id"+EXT,
    :favorites_destroy => API_PATH+"favorites/destroy/id"+EXT,
    #friends
    :friendships_create => API_PATH+"friendships/create"+EXT,
    :friendships_destroy => API_PATH+"friendships/destroy"+EXT,
    :friendships_exists => API_PATH+"friendships/exists"+EXT,
    :friends_ids => API_PATH+"friends/ids"+EXT,
    :followers_ids => API_PATH+"followers/ids"+EXT,
    #notification
    :notifications_follow => API_PATH+"notifications/follow"+EXT,
    :notifications_leave => API_PATH+"notifications/leave"+EXT,
    #Blacklist
    :blocks_create => API_PATH+"blocks/create"+EXT,
    :blocks_destroy => API_PATH+"blocks/destroy"+EXT,
    #account
    :account_verify_credentials => API_PATH+"account/verify_credentials"+EXT,
    #search
    :saved_searches => API_PATH+"saved_searches"+EXT,
    :saved_searches_show_id => API_PATH+"saved_searches/show/id"+EXT,
    :saved_searches_create => API_PATH+"saved_searches/create"+EXT,
    :saved_searches_destroy => API_PATH+"saved_searches/destroy/id"+EXT
  }

  class Fanfou

    def initialize(l, p)
      @loginname = l
      @password  = p
    end

    def public_timeline(count=20, format='')
      params = {'count'=>count, 'format'=>format}
      get(API[:public_timeline], params)
    end

    def friends_timeline(count=20, since_id='', max_id='', page=1, format='')
      params = {
        'count' => count,
        'since_id' => since_id,
        'max_id' => max_id,
        'page' => page,
        'format' => format
      }
      get(API[:friends_timeline], params)
    end

    def user_timeline(count=20, since_id='', max_id='', page=1, format='')
      params = {
        'count' => count,
        'since_id' => since_id,
        'max_id' => max_id,
        'page' => page,
        'format' => format
      }
      get(API[:user_timeline], params)
    end

    def show(msgid)
      params = {'id'=>msgid}
      get(API[:show], params)
    end

    def replies(count=20, since_id='', max_id='', page=1, format='')
      params = {
        'count' => count,
        'since_id' => since_id,
        'max_id' => max_id,
        'page' => page,
        'format' => format
      }
      get(API[:replies], params)
    end

    def mentions(count=20, since_id='', max_id='', page=1, format='')
      params = {
        'count' => count,
        'since_id' => since_id,
        'max_id' => max_id,
        'page' => page,
        'format' => format
      }
      post(API[:mentions], params)
    end

    def update(status, in_reply_to_status_id='', source='', location='')
      params = {
        'status' => status,
        'in_reply_to_status_id' => in_reply_to_status_id,
        'source' => source
      }
      post(API[:update], params)
    end

    def destroy(msgid)
      params = {'id'=>msgid}
      post(API[:destroy], params)
    end

    def photos_upload(photo_full_path, status='', source='', location='')
      raise "Not implemented"
    end

    def search_public_timeline(q, max_id='')
      params = { 'q'=>q, 'max_id'=>max_id }
      get(API[:search_public_timeline], params)
    end

    def trends
      get(API[:trends])
    end

    def users_friends(user_id='', page=1)
      user_id = @loginname if user_id == ''
      params = {
        'id' => user_id,
        'page' => page
      }
      get(API[:users_friends], params)
    end

    def users_followers(user_id='', page=1)
      user_id = @loginname if user_id == ''
      params = {
        'id' => user_id,
        'page' => page
      }
      get(API[:users_followers], params)
    end

    def users_show(user_id='')
      user_id = @loginname if user_id == ''
      params = {
        'id' => user_id
      }
      get(API[:users_show], params)
    end

    def direct_messages_sent(count=20, since_id='', max_id='', page=1)
      params = {
        'count' => count,
        'since_id' => since_id,
        'max_id' => max_id,
        'page' => page,
      }
      post(API[:direct_messages_sent], params)
    end

    def direct_messages_new(user_id, text, in_reply_to_id='')
      params = {
        'user' => user_id,
        'text' => text,
        'in_reply_to_id' => in_reply_to_id
      }
      post(API[:direct_messages_new], params)
    end

    def direct_messages_destroy(msgid)
      params = {'id' => msgid}
      post(API[:direct_messages_destroy], params)
    end

    def favorites(user_id='', count=20, page=1)
      user_id = @loginname if user_id == ''
      params = {
        'id' => user_id,
        'count' => count,
        'page' => page
      }
      get(API[:favorites], params)
    end

    def favorites_create(msgid)
      params = {'id' => msgid}
      post(API[:favorites_create], params)
    end

    def favorites_destroy(msgid)
      params = {'id' => msgid}
      post(API[:favorites_destroy], params)
    end

    def friendships_create(uid)
      post(API[:friendships_create], {'id' => uid})
    end

    def friendships_destroy(uid)
      post(API[:friendships_destroy], {'id' => uid})
    end

    def friendships_exists(user_a, user_b)
      params = {
        'user_a' => user_a,
        'user_b' => user_b
      }
      get(API[:friendships_exists], params)
    end

    def friends_ids(id='')
      user_id = @loginname if user_id == ''
      params = {'id' => id }
      get(API[:friends_ids], params)
    end

    def followers_ids(id='')
      user_id = @loginname if user_id == ''
      params = {'id' => id }
      get(API[:followers_ids], params)
    end

    def notifications_follow(id)
      params = {'id' => id}
      post(API[:notifications_follow], params)
    end

    def notifications_leave(id)
      params = {'id' => id }
      post(API[:notifications_leave], params)
    end

    def blocks_create(id)
      params = {'id' => id }
      post(API[:blocks_create], params)
    end

    def blocks_destroy(id)
      params = {'id' => id }
      post(API[:blocks_destroy], params)
    end

    def saved_searches
      get(API[:saved_searches])
    end

    def saved_searches_show_id(id)
      params = {'id' => id}
      get(API[:saved_searches_show_id], params)
    end

    def saved_searches_create(query)
      params = {'query' => query}
      post(API[:saved_searches_create], params)
    end

    def saved_searches_destroy(id)
      params = {'id' => id}
      post(API[:saved_searches_destroy], params)
    end


    def unfollow(uid)
      friendships_destroy(uid)
    end

    def follow(uid)
      friendships_create(uid)
    end

    def is_friend?(uid)
      friendships_exists(@loginname, uid)
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
