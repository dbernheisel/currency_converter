#!/usr/bin/env ruby

require 'Matrix'
require './Currency'

class CurrencyTrader

  attr_accessor :currency_conversions
  attr_accessor :currency

  # currency_conversions should be an array assumed to be in indexed
  # order from oldest to newest.
  def initialize(currency_conversions, currency)
    @currency_conversions = currency_conversions.sort_by { |currency_conversion, date| date }
    @currency = currency
  end




  def best_trades(currency_conversion_before, currency_conversion_after)

  end

end
