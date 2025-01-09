FactoryBot.define do
  factory :address do
    address { Faker::Address.street_name }
    number { 42 }
    city { 'São Paulo' }
    state { 'SP' }
    postal_code { Faker::Address.zip_code }
    neighborhood { 'Centro' }
    inn
  end
end

# address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM',
# postal_code: '69067-080', neighborhood: 'Centro'}