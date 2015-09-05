#!/usr/bin/env ruby

require_relative './Currency'
require_relative './CurrencyConverter'
require_relative './CurrencyTrader'
require 'date'

# Source http://www.xe.com/currencyconverter/#rates
currency_rates_20150903 = { rates: {
                                    USD: 1.00000,
                                    EUR: 0.89932,
                                    GBP: 0.65558,
                                    INR: 66.0945,
                                    AUD: 1.42636,
                                    CAD: 1.31838,
                                    ZAR: 13.5868,
                                    NZD: 1.56566,
                                    JPY: 120.085
                                  },
                            date: DateTime.new(2015,9,3)
                          }

currency_rates_20150904 = { rates: {
                                    USD: 1.00000,
                                    EUR: 0.89687,
                                    GBP: 0.65829,
                                    INR: 66.6861,
                                    AUD: 1.44442,
                                    CAD: 1.32486,
                                    ZAR: 13.8867,
                                    NZD: 1.58720,
                                    JPY: 118.882
                                  },
                            date: DateTime.new(2015,9,4)
                          }


davidmoney = Currency.new(100, "$")
blakemoney = Currency.new(100, "USD")
juliemoney = Currency.new("€ 20")
indianmoney = Currency.new(300, "INR")
damemoney = Currency.new(3300, "JPY")
# EXPECTED FAILED TEST invalidmoney = Currency.new("100")
# EXPECTED FAILED TEST blakemoney3 = Currency.new("$$100")
invalidmoney2 = Currency.new("jfkd200") rescue "Rescued error"

puts "======= Tests ========="
puts "David Money: #{davidmoney}"
puts "Blake Money: #{blakemoney}"
puts "Julie Money: #{juliemoney}"
puts "Indian Money: #{indianmoney}"
puts "DaMe Money: #{damemoney}"
puts "Invalid Money: #{invalidmoney2}"
puts "To string: #{davidmoney}"
puts "Equality Currency: #{davidmoney == blakemoney}"
puts "Equality string: #{davidmoney == "$100"}"
blakemoney.amount = 20
puts "Blake Amount Set Integer: #{blakemoney}"
blakemoney.amount = "$20"
puts "Blake Amount Set String: #{blakemoney}"
blakemoney.amount = davidmoney.amount
puts "Blake Amount Set David's Money Amount: #{blakemoney}"
blakemoney.amount = "$23.54"
puts "Blake Amount Set Float: #{blakemoney}"
puts "Inequality Currency: #{davidmoney == blakemoney}"
puts "Inequality string: #{davidmoney == "$900"}"
puts "Addition Currency: #{davidmoney + blakemoney}"
puts "Addition integer: #{davidmoney + 11}"
puts "Addition float: #{davidmoney + 10.52}"
puts "Addition string: #{davidmoney + "$23.40"}"
puts "Subtraction: #{davidmoney - blakemoney}"
puts "Multiplication Currency: #{davidmoney * blakemoney}"
puts "Multiplication integer: #{davidmoney * 10}"
puts "Multiplication float: #{davidmoney * 1.532}"
puts "Equal and Addition Currency: #{davidmoney}, and after #{davidmoney += blakemoney}, and again #{davidmoney}"
puts "Equal and Addition Integer: #{davidmoney}, and after #{davidmoney += 10}"
currency_converter_old = CurrencyConverter.new(currency_rates_20150903)
currency_converter_new = CurrencyConverter.new(currency_rates_20150904)
davidmoney_eur = currency_converter_old.convert(davidmoney, "EUR")
puts "Convert USD to EUR: #{davidmoney}, and after: #{davidmoney_eur}"
conversioneq = currency_converter_old.convert(Currency.new(1, "USD"), "USD") == Currency.new(1, "USD")
conversionineq = currency_converter_old.convert(Currency.new(1, "USD"), "USD") == Currency.new(1, "GBP")
puts "Conversion Equality: #{conversioneq}"
puts "Conversion Inequality: #{conversionineq}"
conversionerror = currency_converter_old.convert(Currency.new(1, "USD"), "something") rescue "Rescued error"
puts "Conversion Error (not recognized currency): #{conversionerror}"

puts ""
puts ""
puts "Currency Trader Analytics"
trader = CurrencyTrader.new([currency_converter_old, currency_converter_new], "USD")


