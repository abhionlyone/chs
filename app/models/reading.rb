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

  def self.next_id
    return Rails.cache.read('next_id') if !Rails.cache.read('next_id').nil?
    return Rails.cache.write('next_id', (self.unscoped.order("id DESC").last.id + 1)) && self.next_id if self.first
    return Rails.cache.write('next_id', 1) && self.next_id
  end
end
