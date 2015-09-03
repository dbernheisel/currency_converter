#!/usr/bin/env ruby

require_relative './Currency'
require_relative './CurrencyConverter'
require_relative './CurrencyTrader'

davidmoney = Currency.new("$", 100)
blakemoney = Currency.new("$", 20)

puts davidmoney == blakemoney
puts davidmoney + blakemoney
puts davidmoney - blakemoney