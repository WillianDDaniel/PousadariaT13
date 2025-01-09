FactoryBot.define do
  factory :inn_owner do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    document { Faker::IdNumber.brazilian_citizen_number }
    email { generate :email }
    password { '123456' }
  end
end

# InnOwner.create!(first_name: 'Joao', last_name: 'Almeida', 
# document: '53783222001', email: 'joao@email.com', password: '123456')

