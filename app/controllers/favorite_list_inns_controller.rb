class FavoriteListInnsController < ApplicationController
  def new
    @favorite_list = FavoriteList.find_by(id: params[:favorite_list_id])
    @favorite_list_inn = @favorite_list.favorite_list_inns.build
  end

  def create
    favorite_list_id = params[:favorite_list_inn][:favorite_list_id]
    inn_id = params[:inn_id]

    @favorite_list = FavoriteList.find_by(id: favorite_list_id)
    @inn = Inn.find_by(id: inn_id)

    @favorite_list_inn = FavoriteListInn.new(favorite_list: @favorite_list, inn: @inn)

    if @favorite_list_inn.save
      redirect_to favorite_list_path(@favorite_list), notice: 'Pousada adicionada com sucesso!'
    else
      flash[:alert] = 'Não foi possível adicionar a pousada à lista.'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    favorite_list_inn = FavoriteListInn.find_by(id: params[:id])
    @favorite_list = favorite_list_inn.favorite_list

    if favorite_list_inn.destroy
      return redirect_to @favorite_list, notice: 'Favorito excluído com sucesso!'
    end

    redirect_to redirect_to @favorite_list, alert: 'Não foi possível excluír seu favorito'
  end

  private
  def favorite_list_inn_params
    params.require(:favorite_list_inn).permit(:inn_id, :favorite_list_id)
  end
end