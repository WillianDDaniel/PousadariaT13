class FavoriteListsController < ApplicationController
  def index
    @favorite_lists = current_inn_user.favorite_lists
  end

  def show
    @favorite_list = FavoriteList.find_by(id: params[:id])
  end

  def new
    inn_user = current_inn_user
    @favorite_list = inn_user.favorite_lists.build
  end

  def create
    inn_user = current_inn_user
    @favorite_list = inn_user.favorite_lists.build(favorite_list_params)
    if @favorite_list.save
      flash[:notice] = 'Lista criada com sucesso!'
      redirect_to favorite_lists_path
    end
  end
  
  private

  def favorite_list_params
    params.require(:favorite_list).permit(:name)
  end
end