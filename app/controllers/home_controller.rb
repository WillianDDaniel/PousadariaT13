class HomeController < ApplicationController
  def index
    @inns = Inn.active
  end

  def inn_user
    
  end
end