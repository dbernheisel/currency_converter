#!/usr/bin/env ruby

require_relative './Currency'
require_relative './CurrencyConverter'
require_relative './CurrencyTrader'

davidmoney = Currency.new(100, "$")
blakemoney = Currency.new(100, "USD")
# EXPECTED FAILED TEST invalidmoney = Currency.new("100")
# FAILED TEST blakemoney3 = Currency.new("$$100")
invalidmoney2 = Currency.new("jfkd200") rescue "Rescued error"

puts "======= Tests ========="
puts "David Money: #{davidmoney}"
puts "Blake Money: #{blakemoney}"
#puts "David2 Money: #{davidmoney2}"
#puts "Blake3 Money: #{blakemoney3}"
puts "Invalid Money: #{invalidmoney2}"
puts "To string: #{davidmoney}"
puts "Equality Currency: #{davidmoney == blakemoney}"
puts "Equality string: #{davidmoney == "$100"}"
blakemoney.amount = 20
puts "Inequality Currency: #{davidmoney == blakemoney}"
puts "Inequality string: #{davidmoney == "$900"}"
puts "Addition Currency: #{davidmoney + blakemoney}"
puts "Addition integer: #{davidmoney + 10}"
puts "Addition float: #{davidmoney + 10.52}"
puts "Addition string: #{davidmoney + "$23.40"}"
puts "Subtraction: #{davidmoney - blakemoney}"
puts "Multiplication Currency: #{davidmoney * blakemoney}"
puts "Multiplication integer: #{davidmoney * 10}"
puts "Multiplication float: #{davidmoney * 1.5}"
puts "Equal and Addition Currency: #{davidmoney += blakemoney}, and after #{davidmoney}"
puts "Equal and Addition Integer: #{davidmoney += 10}, and after #{davidmoney}"
# converter = CurrencyConverter.new()
# conversion = converter.convert(davidmoney, "EUR")
# puts "Convert USD to EUR: #{conversion}"