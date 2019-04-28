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
    return Rails.cache.write("thermostat_#{self.id}", 1) && self.next_reading_number
  end

  def find_reading_by_id(id)
    Rails.cache.fetch(["reading_#{id}"]) do
      self.readings.where(id: id).first
    end
  end

  def stats
    Rails.cache.fetch(["stats_#{id}"]) do
      {
        readings_count: readings.count,
        temperature: {
          max: readings.maximum('temperature'),
          min: readings.minimum('temperature'),
          avg: readings.average('temperature')
        },
        humidity: {
          max: readings.maximum('humidity'),
          min: readings.minimum('humidity'),
          avg: readings.average('humidity')
        },
        battery_charge: {
          max: readings.maximum('battery_charge'),
          min: readings.minimum('battery_charge'),
          avg: readings.average('battery_charge')
        }
      }
    end
  end
end
