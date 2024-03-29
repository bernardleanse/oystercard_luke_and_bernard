class JourneyLog
  attr_reader :current_journey
  def initialize(journey_class = Journey)
    @list_of_journeys = []
    @journey_class = journey_class
    @current_journey = nil
  end

  def start_journey(station_name)
    @current_journey = @journey_class.new
    @current_journey.start(station_name)
  end

  def on_journey?
    !@current_journey.nil?
  end

  def end_journey(station_name)
    @current_journey.end(station_name)
    store_journey
    @current_journey = nil
  end

  def print
    @list_of_journeys.each { |journey| puts "#{journey.entry_station} ----->  #{journey.exit_station}"}
  end

  private


  def store_journey
    @list_of_journeys.append(@current_journey)
  end

end