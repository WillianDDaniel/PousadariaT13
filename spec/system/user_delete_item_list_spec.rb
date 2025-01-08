require 'rails_helper'

describe 'Usuário deleta um item de sua lista' do
  it 'com sucesso' do
    user = InnUser.create!(name: 'leandro', email: 'leandro@email.com', password: '123456')

    inn_owner_first = InnOwner.create!(email: 'leandro@email.com', password: '123456', first_name: 'Leandro', last_name: 'Carvalho', document: '95006658088')
    first_inn = inn_owner_first.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
      address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    favorite_list = user.favorite_lists.create!(name: 'Lista de pousadas1')

    inn_owner_second = InnOwner.create!(email: 'user2@email.com', password: '123456', first_name: 'user2', last_name: 'dois', document: '913.694.470-00')
    second_inn = inn_owner_second.create_inn!(name: 'Pousada dos Quase-devs', registration_number: '19151059000109', description: 'Um bom lugar', 
      address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    FavoriteListInn.create!(inn: first_inn, favorite_list: favorite_list)
    FavoriteListInn.create!(inn: second_inn, favorite_list: favorite_list)

    login_as user, scope: :inn_user
    visit root_path
    click_on 'Lista de Favoritos'
    click_on 'Lista de pousadas1'
    page.find("#inn_#{first_inn.id}").click

    expect(page).to have_content 'Favorito excluído com sucesso!'
    expect(page).not_to have_content 'Pousada do Almeidinha'
    expect(page).to have_content 'Pousada dos Quase-devs'
  end
end