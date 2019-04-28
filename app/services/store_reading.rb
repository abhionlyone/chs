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
    update_stats
    @reading
  end

  def update_stats
    stats = Rails.cache.read("stats_#{@reading.thermostat_id}") || @reading.thermostat.stats
    stats = {
      temperature: {
        max: max_number(stats[:temperature][:max], @reading.temperature),
        min: min_number(stats[:temperature][:min], @reading.temperature),
        avg: average(stats[:readings_count], stats[:temperature][:avg], @reading.temperature)
      },
      humidity: {
        max: max_number(stats[:humidity][:max], @reading.humidity),
        min: min_number(stats[:humidity][:min], @reading.humidity),
        avg: average(stats[:readings_count], stats[:humidity][:avg], @reading.humidity)
      },
      battery_charge: {
        max: max_number(stats[:battery_charge][:max], @reading.battery_charge),
        min: min_number(stats[:battery_charge][:min], @reading.battery_charge),
        avg: average(stats[:readings_count], stats[:battery_charge][:avg], @reading.battery_charge)
      },
      readings_count: increment(stats[:readings_count])
    }
    Rails.cache.write("stats_#{@reading.thermostat_id}", stats)
  end

  private


  def max_number(num1, num2)
     return num1 if num2.nil?
     return num2 if num1.nil?
     num1 > num2 ? num1 : num2
  end

  def min_number(num1, num2)
    return num1 if num2.nil?
    return num2 if num1.nil?
    num1 < num2 ? num1 : num2
  end

  def average(current_count, current_average, value)
    return value if current_count == 0
    sum = current_average.to_f * current_count + value
    size = current_count + 1
    sum/(current_count + 1)
  end

  def increment(num)
    num + 1
  end

end


# reading = Reading.new(thermostat: Thermostat.last, temperature: 22.3, humidity: 50, battery_charge: 100)