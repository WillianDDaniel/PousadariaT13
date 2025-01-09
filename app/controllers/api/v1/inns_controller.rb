class Api::V1::InnsController < Api::V1::ApiController
    def index
        @inn = Inn.all
        render status: 200, json: @inn        
    end

    def show
      inn = Inn.find_by!(id: params[:id])

      render status: :ok, json: { inn: inn }
    end
end