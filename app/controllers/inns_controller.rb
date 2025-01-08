class InnsController < ApplicationController
  def show
    @inn = Inn.find(params[:id])
    @favorite_lists = current_inn_user.favorite_lists if inn_user_signed_in?

    @favorite_list_inn = FavoriteListInn.new
  end
end