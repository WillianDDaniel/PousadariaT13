require 'rails_helper'

describe 'Api Inn' do
  context 'GET api/v1/inns' do
    it 'com sucesso' do
      inns = []
      5.times do |n|
        inns << create(:inn, name: "Pousada #{n + 1}")
      end

      get api_v1_inns_path

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 5
      expect(json_response[0]['name']).to eq 'Pousada 1'
      expect(json_response[1]['name']).to eq 'Pousada 2'
      expect(json_response[2]['name']).to eq 'Pousada 3'
      expect(json_response[3]['name']).to eq 'Pousada 4'
      expect(json_response[4]['name']).to eq 'Pousada 5'
    end

    it 'internal error' do
      inns = []
      5.times do |n|
        inns << create(:inn, name: "Pousada #{n + 1}")
      end
      allow(Inn).to receive(:all).and_raise(ActiveRecord::ActiveRecordError)

      get api_v1_inns_path

      expect(response).to have_http_status(:internal_server_error)
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['internal_server_error']).to eq 'Algo deu errado: Erro interno!'
    end
  end

  context 'GET api/v1/inns/:id' do
    it 'com sucesso' do
      inn = create(:inn, name: 'Pousada dos sonhos')
      address = { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'}
      inn.address_attributes = address

      get api_v1_inn_path(inn)

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 1
      expect(json_response['inn']['name']).to eq 'Pousada dos sonhos'
      expect(json_response['inn']['address_attributes']['street']).to eq address.street
      expect(json_response['inn']['address_attributes']['city']).to eq address.city
      expect(json_response['inn']['address_attributes']['state']).to eq address.state
      expect(json_response['inn']['address_attributes']['neighborhood']).to eq address.neighborhood
    end
  end
end

