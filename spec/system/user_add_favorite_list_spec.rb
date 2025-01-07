require 'rails_helper'

describe 'Usuário cria lista de favoritos' do
  it 'e deve estar autenticado' do
    visit root_path

    within 'nav' do
      expect(page).not_to have_link 'Lista de Favoritos'
    end
  end

  it 'com sucesso' do
    inn_owner = InnOwner.create!(email: 'leandro@email.com', password: '123456', first_name: 'Leandro', last_name: 'Carvalho', document: '95006658088')
    inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
      address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    login_as inn_owner, scope: :inn_owner
    visit root_path
    expect(page).to have_content 'Lista de Favoritos'
  end

  it 'e ve sua lista de favoritos' do
    inn_owner = InnOwner.create!(email: 'leandro@email.com', password: '123456', first_name: 'Leandro', last_name: 'Carvalho', document: '95006658088')
    inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
      address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})
    inn_owner.favorite_lists.create!(name: 'Lugares de verão')

    login_as inn_owner, scope: :inn_owner
    visit root_path
    click_on 'Lista de Favoritos'

    expect(page).to have_content 'Lugares de verão'
  end
end