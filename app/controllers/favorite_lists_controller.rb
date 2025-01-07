class FavoriteListsController < ApplicationController
  def index
    @favorite_lists = owner_active.favorite_lists
  end
end