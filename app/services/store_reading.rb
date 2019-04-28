class StoreReading
  def initialize(reading)
    @reading = reading
  end

  def process
    @reading.id = Reading.random_id
    @reading.number = @reading.thermostat.next_reading_number
    @reading.created_at = @reading.updated_at = Time.now
    # Added a delay of 30 seconds before creating a record in database.
    StoreReadingWorker.perform_in(30.seconds, @reading.thermostat_id, @reading.id) 

    Rails.cache.write("thermostat_#{@reading.thermostat.id}", @reading.number + 1)
    Rails.cache.write("reading_#{@reading.id}", @reading)
    @reading
  end
end


# reading = Reading.new(thermostat: Thermostat.last, temperature: 22.3, humidity: 50, battery_charge: 100)