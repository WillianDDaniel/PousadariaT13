class InnOwner < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :inn
  accepts_nested_attributes_for :inn
  validates :first_name, :last_name, :document, presence: true
  validates :document, uniqueness: true
end
