require 'rails_helper'

RSpec.describe FavoriteList, type: :model do
  context '#valid?' do
    it { have_many(:inns).through(:favorite_list_inns) }
    it { belong_to(:inn_user)}
    it { have_many(:favorite_list_inns).dependent(:destroy) }
    it { validate_presence_of(:name) }
    it 'deve ter um nome para ser valido' do
      favorite_list = FavoriteList.new(name: '')
      favorite_list.valid?
      expect(favorite_list.errors[:name]).to include('não pode ficar em branco')
    end
  end
end