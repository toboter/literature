class HomeController < ApplicationController
  require 'net/http'
  
  def index
    if current_user
      source = "http://localhost:3000/api/me?access_token=#{session[:access_token]}"
      resp = Net::HTTP.get_response(URI.parse(source))
      data = resp.body
      @data = JSON.parse(data)
    end
  end
  
end
