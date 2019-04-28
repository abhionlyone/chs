10.times do 
  Thermostat.create(household_token: SecureRandom.uuid, location: Faker::Address.full_address)
end