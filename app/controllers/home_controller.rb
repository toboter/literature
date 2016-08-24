class HomeController < ApplicationController

  def index
    @data = access_token.get("/api/me").parsed if current_user && access_token
  end
  
end
