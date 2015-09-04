#!/usr/bin/env ruby

require_relative './Currency'
require_relative './CurrencyConverter'
require_relative './CurrencyTrader'

davidmoney = Currency.new(100, "$")
blakemoney = Currency.new(100, "USD")
juliemoney = Currency.new("€ 20")
indianmoney = Currency.new(300, "INR")
# EXPECTED FAILED TEST invalidmoney = Currency.new("100")
# EXPECTED FAILED TEST blakemoney3 = Currency.new("$$100")
invalidmoney2 = Currency.new("jfkd200") rescue "Rescued error"

puts "======= Tests ========="
puts "David Money: #{davidmoney}"
puts "Blake Money: #{blakemoney}"
puts "Julie Money: #{juliemoney}"
puts "Indian Money: #{indianmoney}"
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
puts "Multiplication float: #{davidmoney * 1.532}"
puts "Equal and Addition Currency: #{davidmoney}, and after #{davidmoney += blakemoney}"
puts "Equal and Addition Integer: #{davidmoney}, and after #{davidmoney += 10}"
davidmoney_eur = CurrencyConverter.convert(davidmoney, "EUR")
puts "Convert USD to EUR: #{davidmoney}, and after: #{davidmoney_eur}"
conversioneq = CurrencyConverter.convert(Currency.new(1, "USD"), "USD") == Currency.new(1, "USD")
conversionineq = CurrencyConverter.convert(Currency.new(1, "USD"), "USD") == Currency.new(1, "GBP")
puts "Conversion Equality: #{conversioneq}"
puts "Conversion Inequality: #{conversionineq}"
conversionerror = CurrencyConverter.convert(Currency.new(1, "USD"), "something") rescue "Rescued error"
puts "Conversion Error (not recognized currency): #{conversionerror}"