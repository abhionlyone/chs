# == Schema Information
#
# Table name: readings
#
#  id             :string(255)      not null, primary key
#  battery_charge :float(24)
#  humidity       :float(24)
#  number         :integer
#  temperature    :float(24)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  thermostat_id  :bigint
#
# Indexes
#
#  index_readings_on_thermostat_id             (thermostat_id)
#  index_readings_on_thermostat_id_and_number  (thermostat_id,number) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (thermostat_id => thermostats.id)
#

class Reading < ApplicationRecord
  belongs_to :thermostat

  def self.random_id
    id = SecureRandom.hex
    return id if Reading.where(id: id).first.nil? &&  Rails.cache.read "reading_#{id}".nil?
    self.random_id
  end
end
