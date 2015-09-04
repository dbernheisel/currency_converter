#!/usr/bin/env ruby
require './Currency'

class NotCurrency < RuntimeError

end

class CurrencyConverter

  #attr_accessor :source_currency DEFINED MANUALLY
  #attr_accessor :target_currency_code DEFINED MANUALLY
  attr_accessor :rate

  @@rates = { "USD" => {
                    "USD" => 1.00000,
                    "EUR" => 0.89932,
                    "GBP" => 0.65558,
                    "INR" => 66.0945,
                    "AUD" => 1.42636,
                    "CAD" => 1.31838,
                    "ZAR" => 13.5868,
                    "NZD" => 1.56566,
                    "JPY" => 120.085
                    },
              "EUR" => {
                    "USD" => 1.11197,
                    "EUR" => 1.00000,
                    "GBP" => 0.72897,
                    "INR" => 73.4954,
                    "AUD" => 1.58643,
                    "CAD" => 1.46597,
                    "ZAR" => 15.1073,
                    "NZD" => 1.74092,
                    "JPY" => 133.538
                    }
            }

  def initialize
    # sit pretty
  end

  def source_currency=(setter)
    if setter.is_a?(Currency)
      @source_currency = setter
    else
      raise NotCurrency, "#{setter} is not a valid Currency object"
    end
  end

  def source_currency
    @source_currency
  end

  def target_currency_code=(setter)
    unless setter.nil? || setter.empty?
      @target_currency_code = @source_currency.find_currency_code(setter)
      if @target_currency_code.nil?
        raise NotCurrency, "Not a valid Currency object"
      end
    end
  end

  def target_currency_code
    @target_currency_code
  end

  def self.convert(from, to)
    dude = new
    dude.source_currency = from
    dude.target_currency_code = to
    @rate = @@rates[dude.source_currency.currency][dude.target_currency_code]
    return Currency.new(dude.source_currency.amount * @rate, dude.target_currency_code)
  end

  def to_s
    "#{@source_currency} to #{@target_currency_code} at rate #{@rate}"
  end

end