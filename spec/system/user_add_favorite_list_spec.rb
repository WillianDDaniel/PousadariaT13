require 'rails_helper'

describe 'Usuário tem acesso a favoritos' do
  it 'e deve estar autenticado' do
    visit root_path

    within 'nav' do
      expect(page).not_to have_link 'Lista de Favoritos'
    end
  end

  it 'e faz login com sucesso' do
    InnUser.create!(name: 'leandro', email: 'leandro@email.com', password: '123456')

    visit root_path
    click_on 'Reservar pousada'
    click_on 'Fazer login'

    fill_in 'E-mail', with: 'leandro@email.com'
    fill_in 'Senha',  with: '123456'
    click_on 'Entrar'
    
    expect(page).to have_content 'Lista de Favoritos'
  end

  it 'e ve sua lista de favoritos' do
    user = InnUser.create!(name: 'leandro', email: 'leandro@email.com', password: '123456')

    user.favorite_lists.create!(name: 'Pousadas para visitar')
    user.favorite_lists.create!(name: 'Pousadas para não visitar')

    login_as user, scope: :inn_user

    visit root_path
    click_on 'Lista de Favoritos'

    expect(page).to have_content 'Pousadas para visitar'
    expect(page).to have_content 'Pousadas para não visitar'
  end

  it 'e cria uma nova lista' do
    user = InnUser.create!(name: 'leandro', email: 'leandro@email.com', password: '123456')

    login_as user, scope: :inn_user
    visit root_path
    click_on 'Lista de Favoritos'
    click_on 'Nova lista'
    fill_in 'Nome da lista', with: 'Pousadas para visitar'
    click_on 'Criar Lista'

    expect(current_path).to eq favorite_lists_path
    expect(page).to have_content 'Lista criada com sucesso!'
    expect(page).to have_content 'Pousadas para visitar'
  end

  it 'e adiciona uma nova pousada a uma lista existente' do
    user = InnUser.create!(name: 'leandro', email: 'leandro@email.com', password: '123456')
    inn_owner_first = InnOwner.create!(email: 'leandro@email.com', password: '123456', first_name: 'Leandro', last_name: 'Carvalho', document: '95006658088')
    inn_owner_first.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
      address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})
    user.favorite_lists.create!(name: 'Lista de pousadas1')

    inn_owner_second = InnOwner.create!(email: 'user2@email.com', password: '123456', first_name: 'user2', last_name: 'dois', document: '913.694.470-00')
    inn_owner_second.create_inn!(name: 'Pousada dos Quase-devs', registration_number: '19151059000109', description: 'Um bom lugar', 
      address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})
    
    login_as user, scope: :inn_user
    visit root_path
    click_on 'Pousada do Almeidinha'
    select 'Lista de pousadas1', from: 'Listas'
    click_on 'Adicionar Favorito'

    expect(page).to have_content 'Pousada do Almeidinha'
    expect(page).to have_content 'Detalhes da lista Lista de pousadas1'
    expect(current_path).to eq favorite_list_path(FavoriteList.last)
    expect(page).not_to have_content 'Pousada dos Quase-devs'
  end
end