#!/usr/bin/env ruby

class NoAmountCodeError < RuntimeError

end

class NoCurrencyCodeError < RuntimeError

end

class Currency

  attr_accessor :amount

  # Source http://www.xe.com/symbols.php
  # TODO: import from a CSV file for complete mapping that's easy to manage.
  @@CurrencyHash = {
    "USD" => "$",
    "EUR" => "€",
    "GBP" => "£",
    "INR" => " ",
    "CAD" => "$",
    "AUD" => "$",
    "ZAR" => "R",
    "NZD" => "$",
    "JPY" => "¥"
  }

  def find_currency_code(money)
    # Return nothing if nothing's really there.
    return nil if money == "" || money == nil
    return money.currency if money.class == Currency
    textinmoney = money.to_s.gsub(/[^\D]/, "").upcase.strip
    return nil if textinmoney == "" || textinmoney == nil

    # Prefer 3-letter abbreviation since it's exact.
    return textinmoney if @@CurrencyHash.has_key?(textinmoney)

    # Map symbol to 3-letter abbreviation
    return @@CurrencyHash.key(textinmoney)

  end

  def initialize(amount, currencycode = nil)
    #puts "Before: #{amount} #{currencycode}"
    if currencycode
      self.currency = find_currency_code(currencycode)
    else
      self.currency = find_currency_code(amount)
    end
    self.amount = amount
    #puts "After: #{@amount} #{@currency}"
  end

  def currency=(setter)
    currencycode = find_currency_code(setter)
    if currencycode.nil? || currencycode.empty?
      raise NoCurrencyCodeError, "Cannot determine currency code of #{setter}"
    end
    @currency = currencycode
  end

  def currency
    @currency
  end

  def amount=(setter)
    amount = setter.to_s.strip
    numbersinamount = amount.gsub(/[^\d\.]/, "")
    raise NoAmountCodeError, "Cannot determine amount: #{setter}" if numbersinamount == ""
    @amount = numbersinamount.to_f
  end

  def amount
    @amount
  end



  def to_s
    "#{@@CurrencyHash[@currency]}#{sprintf "%.2f" % @amount} #{@currency}"
  end

  def ==(money)
    money.class == Currency ? moneyObj = money : moneyObj = Currency.new(money) rescue false
    return false unless moneyObj
    self.to_s == moneyObj.to_s
  end

  def +(money)
    currencycode = find_currency_code(money)
    currencycode && money.class == Currency ? moneyObj = money : moneyObj = Currency.new(money, self.currency)
    raise DifferentCurrencyCodeError, "Cannot add different currencies" unless self.currency == moneyObj.currency
    Currency.new(self.amount + moneyObj.amount, self.currency) if self.currency == moneyObj.currency
  end

  def -(money)
    currencycode = find_currency_code(money)
    currencycode && money.class == Currency ? moneyObj = money : moneyObj = Currency.new(money, self.currency)
    raise DifferentCurrencyCodeError, "Cannot subtract different currencies" unless self.currency == moneyObj.currency
    Currency.new(self.amount - moneyObj.amount, self.currency) if self.currency == moneyObj.currency
  end

  def *(money)
    currencycode = find_currency_code(money)
    currencycode && money.class == Currency ? moneyObj = money : moneyObj = Currency.new(money, self.currency)
    raise DifferentCurrencyCodeError, "Cannot multiply different currencies" unless self.currency == moneyObj.currency
    Currency.new(self.amount * moneyObj.amount, self.currency) if self.currency == moneyObj.currency
  end

end





