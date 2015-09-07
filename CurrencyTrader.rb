#!/usr/bin/env ruby

require 'Matrix'
require './Currency'
require './CurrencyConverter'

class CurrencyTrader

  attr_accessor :currency_conversions
  attr_accessor :source_currency

  # currency_conversions should be an array assumed to be in indexed
  # order from oldest to newest.
  def initialize(currency_conversions, source_currency)
    @currency_conversions = currency_conversions #currency_conversions.sort_by { |currency_conversion, date| date }
    @source_currency = source_currency
  end

  def best_currency(earlier_conversion, later_conversion)
    best_conversion_amount = 0.0
    best_conversion_currency = nil

    earlier_conversion.rates.each do |currency, rate|
      #puts "Checking #{earlier_conversion.source_currency.to_s} through #{currency}"
      early_amount_currency = earlier_conversion.convert(earlier_conversion.source_currency, currency.to_sym)
      later_amount_currency = later_conversion.convert(early_amount_currency, earlier_conversion.source_currency.currency)
      #puts "#{earlier_conversion.source_currency.to_s} > #{later_amount_currency.to_s} ?"
      if later_amount_currency.amount > best_conversion_amount
        best_conversion_amount = later_amount_currency.amount
        best_conversion_currency = currency
      end
    end

    return best_conversion_currency

  end

  def best_currency_path
    best_path_currencies = []
    i = 0
    until i > @currency_conversions.length
      best_currency_code = self.best_currency(@currency_conversions[i], @currency_conversions[i+1])
      best_currency_conversion = CurrencyConverter.new(@currency_conversions[i].source_currency, best_currency_code)
      best_path_currencies << best_currency_conversion
      i += 1
    end
  end

end
