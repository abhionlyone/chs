FactoryBot.define do
  factory :thermostat do
    household_token {SecureRandom.uuid}
    location {Faker::Address.full_address}  
  end

  factory :reading do
    temperature {Faker::Number.between(from = -50.00, to = 80.00)}
    humidity {Faker::Number.between(from = 1.00, to = 100.00)} 
    battery_charge  {Faker::Number.between(from = 0.00, to = 100.00)}
    thermostat_id {nil}
  end
end