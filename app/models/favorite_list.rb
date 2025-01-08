class FavoriteList < ApplicationRecord
  belongs_to :inn_user
  has_many :favorite_list_inns, dependent: :destroy
  has_many :inns, through: :favorite_list_inns

  validates :name, presence: true
end
