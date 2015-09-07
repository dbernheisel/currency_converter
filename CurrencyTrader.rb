#!/usr/bin/env ruby

require 'Matrix'
require './Currency'
require './CurrencyConverter'

class CurrencyTrader

  attr_accessor :currency_conversions
  attr_accessor :source_currency
  attr_accessor :best_currency_path

  # currency_conversions should be an array assumed to be in indexed
  # order from oldest to newest.
  def initialize(currency_conversions, source_currency)
    @currency_conversions = currency_conversions #currency_conversions.sort_by { |currency_conversion, date| date }
    @source_currency = source_currency
    @best_path_currencies = []
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
    best_conversion_currency
  end

  def profit_in_trade(earlier_conversion, later_conversion)
    best_currency = self.best_currency(earlier_conversion, later_conversion)
    early_amount_currency = earlier_conversion.convert(earlier_conversion.source_currency, best_currency)
    later_amount_currency = later_conversion.convert(earlier_conversion.source_currency, best_currency)
    return later_amount_currency.amount - early_amount_currency.amount
  end

  def best_currency_path
    i = 0
    loop do
      break if i + 1 == @currency_conversions.length
      best_currency_code = self.best_currency(@currency_conversions[i], @currency_conversions[i+1])
      @best_path_currencies.push(best_currency_code)
      i += 1
    end
    @best_path_currencies
  end

  def best_currency_amount
    self.best_currency_path if @best_currency_path == []
    return nil if @best_currency_path == []
    profits = 0
    loop do
      break if i + 1 == @best_currency_path.length
      profits += self.profit_in_trade(@currency_conversions[i], @currency_conversions[i+1])
      i += 1
    end
    Currency.new(profits, @source_currency)
  end

  def give_advice
    # returns {1: [olddate, newdate, currency, profit]
    #          2: [olddate, newdate, currency, profit]}
    advice = {}
    i = 1
    loop do
      break if i == currency_conversions.length
      best_currency = self.best_currency(currency_conversions[i-1], currency_conversions[i])
      profit = self.profit_in_trade(currency_conversions[i-1], currency_conversions[i])
      olddate = currency_conversions[i-1].rate_date
      newdate = currency_conversions[i].rate_date
      advice[i] = [olddate, newdate, best_currency, profit]
      i += 1
    end
    advice
  end
end
