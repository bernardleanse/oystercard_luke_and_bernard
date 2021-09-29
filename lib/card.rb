# frozen_string_literal: true

class Oystercard
  attr_reader :balance, :list_of_journeys, :journey
  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90

  def initialize
    @balance = DEFAULT_BALANCE
    @list_of_journeys = []
  end

  def top_up(amount)
    raise "This exceeds max balance of #{MAX_BALANCE}" if @balance + amount > MAX_BALANCE

    @balance += amount
  end

  def touch_in(station_name) 
    raise 'Cannot touch in, balance is below min balance' if below_min_balance?
    raise 'Cannot touch in, already on journey' if on_journey?

    @journey = Journey.new
    @journey.start(station_name)
  end

  def touch_out(station_name)
    raise 'Cannot touch out, not on a journey' unless on_journey?

    charge
    @journey.end(station_name)
    store_journey
  end

  private

  def below_min_balance?
    @balance < MIN_FARE
  end

  def deduct(amount)
    @balance -= amount
  end

  def on_journey?
    !@journey.nil?
  end

  def store_journey
    @list_of_journeys.append(@journey)
  end

  def charge
    @balance -= journey.fare
  end

end
