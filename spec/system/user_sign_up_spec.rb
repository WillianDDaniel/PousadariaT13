require 'rails_helper'

describe 'Usuário cria conta' do
  it 'com sucesso' do
    visit root_path
    click_on 'Reservar pousada'
    click_on 'Criar conta'
    fill_in 'Nome', with: 'NomeTesteInnUser'
    fill_in 'E-mail', with: 'teste@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Criar Usuário'

    expect(InnUser.count).to eq 1
    within 'nav' do
      expect(page).to have_content 'teste@email.com'
    end
    expect(current_path).to eq root_path
  end
end