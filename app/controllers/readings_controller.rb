class ReadingsController < ApplicationController

  def create
    reading = Reading.new(reading_params)
    if reading.valid?
      render json: StoreReading.new(reading).process
    else
      render_object_errors(reading)
    end
  end

  def show
    reading = Reading.find_by_id params[:id]
    if reading
      render json: reading
    else
      render_404
    end
  end

  def stats
    thermostat = Thermostat.find params[:id]
    render json: thermostat.stats
  end

  private

  def reading_params
    params.require(:reading).permit(:thermostat_id, :battery_charge, :humidity, :temperature)
  end
end