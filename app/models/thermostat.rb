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

  def next_reading_number
    return Rails.cache.read("thermostat_#{self.id}") if !Rails.cache.read("thermostat_#{self.id}").nil?
    return Rails.cache.write("thermostat_#{self.id}", (self.readings.order("id DESC").last.id + 1)) && self.next_reading_number if self.readings.first
    return Rails.cache.write("thermostat_#{self.id}", 1) && self.next_id
  end
end
