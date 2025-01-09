FactoryBot.define do
  factory :inn do
    name { 'Default Inn' }
    registration_number  { Faker::Company.brazilian_company_number(formatted: false) }
    inn_owner
  end
end
