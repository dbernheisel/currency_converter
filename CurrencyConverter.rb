#!/usr/bin/env ruby
require './Currency'

class InvalidCurrency < RuntimeError

end

class InvalidRateTable < RuntimeError

end

class NotInitialized < RuntimeError

end

class CurrencyConverter

  #attr_accessor :source_currency DEFINED MANUALLY
  #attr_accessor :target_currency_code DEFINED MANUALLY
  attr_accessor :rates, :rate
  attr_accessor :rate_target
  attr_accessor :rate_source
  attr_accessor :rate_date

  # Store the rate_table and grab some info from it, such as the date and
  # exchange rates.
  def initialize(rate_table)
    raise InvalidRateTable, "#{rate_table} is not a valid Hash" unless rate_table.is_a?(Hash)
    @rates = rate_table[:rates] if rate_table.has_key?(:rates)
    @rate_date = rate_table[:date] if rate_table.has_key?(:date)
  end

  # Validate currency attempted during set.
  def source_currency=(setter)
    setter.is_a?(Currency) ? @source_currency = setter : raise(InvalidCurrency, "#{setter} is not a valid Currency object")
  end

  def source_currency
    @source_currency
  end

  # Validate currency code attempted during set.
  # To do this, I need access to the find_currency_code method inside of
  # the Currency class, so I'm using the @source_currency to use it.
  def target_currency_code=(setter)
    raise NotInitialized, "Cannot set target currency until source currency is provided" unless @source_currency
    currency_code = @source_currency.find_currency_code(setter)
    raise InvalidCurrency, "Not a valid Currency object" unless currency_code
    @target_currency_code = currency_code
  end

  def target_currency_code
    @target_currency_code
  end

  # Convert the Currency to a desired currency code.
  def convert(from, to)
    self.source_currency = from
    self.target_currency_code = to
    @rate_source = @rates[@source_currency.currency.to_sym]
    @rate_target = @rates[@target_currency_code.to_sym]
    @rate = (@rate_target / @rate_source)
    return Currency.new(@source_currency.amount * @rate, @target_currency_code)
  end


  def to_s
    "#{@source_currency} to #{@target_currency_code} at rate #{@rate}"
  end

end
