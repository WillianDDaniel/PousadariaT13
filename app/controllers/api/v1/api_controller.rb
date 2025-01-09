class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::ActiveRecordError, with: :internal_server_error

  def internal_server_error
    render status: :internal_server_error, json: { 'internal_server_error': 'Algo deu errado: Erro interno!' }
  end

end