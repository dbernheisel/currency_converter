#!/usr/bin/env ruby
require './Currency'

class CurrencyConverter

  attr_accessor :target_currency
  attr_accessor :source_currency

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

  def initialize(from, to=nil)
    @source_currency = from
    to = Currency ? @target_currency = to : @target_currency = Currency.new(to) unless to == nil
    self.convert(from, to) unless to == nil
  end

  def convert(from, to)
    rate = @@rates[from.currency][to]
    Currency.new(from.amount * rate, to)
  end
end