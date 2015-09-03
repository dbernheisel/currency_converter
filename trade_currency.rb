#!/usr/bin/env ruby

require_relative './Currency'
require_relative './CurrencyConverter'
require_relative './CurrencyTrader'

davidmoney = Currency.new("$", 100)
blakemoney = Currency.new("L", 100)

puts davidmoney == blakemoney
puts davidmoney + blakemoney