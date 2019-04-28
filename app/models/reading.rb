# == Schema Information
#
# Table name: readings
#
#  id             :bigint           not null, primary key
#  thermostat_id  :bigint
#  number         :integer
#  temperature    :float(24)
#  humidity       :float(24)
#  battery_charge :float(24)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Reading < ApplicationRecord
  belongs_to :thermostat
end
