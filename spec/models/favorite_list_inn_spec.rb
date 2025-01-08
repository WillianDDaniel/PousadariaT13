require 'rails_helper'

RSpec.describe FavoriteListInn, type: :model do
  context '#valid?' do
    it{ should belong_to(:inn) }
    it{ should belong_to(:favorite_list) }
  end
end
