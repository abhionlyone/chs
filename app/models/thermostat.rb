# == Schema Information
#
# Table name: thermostats
#
#  id              :bigint           not null, primary key
#  household_token :string(255)
#  location        :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Thermostat < ApplicationRecord
  has_many :readings
end
