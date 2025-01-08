require 'rails_helper'

RSpec.describe InnUser, type: :model do
  context '#valid?' do
    it { should validate_presence_of(:name) }
  end
end
