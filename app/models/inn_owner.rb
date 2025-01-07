class InnOwner < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :inn
  has_many :favorite_lists
  accepts_nested_attributes_for :inn
  validates :first_name, :last_name, :document, presence: true
  validates :document, uniqueness: true
end
