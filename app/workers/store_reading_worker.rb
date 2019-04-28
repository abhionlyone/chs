class StoreReadingWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(thermostat_id, reading_id)
    thermostat = Thermostat.find thermostat_id
    reading = thermostat.find_reading_by_id reading_id
    reading.save!
  end
end