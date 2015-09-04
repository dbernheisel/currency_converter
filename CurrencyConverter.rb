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
  attr_accessor :rates
  attr_accessor :rate_target
  attr_accessor :rate_source

  def initialize(rate_table)
    if rate_table.is_a?(Hash)
      @rates = rate_table
    else
      raise InvalidRateTable, "#{rate_table} is not a valid Hash"
    end
  end

  def source_currency=(setter)
    if setter.is_a?(Currency)
      @source_currency = setter
    else
      raise InvalidCurrency, "#{setter} is not a valid Currency object"
    end
  end

  def source_currency
    @source_currency
  end

  def target_currency_code=(setter)
    unless @source_currency
      raise NotInitialized, "Cannot set target currency until source currency is provided"
    end
    currency_code = @source_currency.find_currency_code(setter)
    unless currency_code
      raise InvalidCurrency, "Not a valid Currency object"
    end
    @target_currency_code = currency_code
  end

  def target_currency_code
    @target_currency_code
  end

  def convert(from, to)
    self.source_currency = from
    self.target_currency_code = to
    @rate_source = @rates[@source_currency.currency.to_sym]
    @rate_target = @rates[@target_currency_code.to_sym]
    rate = (@rate_target / @rate_source)
    return Currency.new(@source_currency.amount * rate, @target_currency_code)
  end

  def to_s
    "#{@source_currency} to #{@target_currency_code} at rate #{@rate}"
  end

end