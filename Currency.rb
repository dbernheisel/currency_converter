#!/usr/bin/env ruby

class NoAmountCodeError < RuntimeError

end

class NoCurrencyCodeError < RuntimeError

end

class DifferentCurrencyCodeError < RuntimeError

end

class Currency

  attr_accessor :amount

  # Source http://www.xe.com/symbols.php
  # TODO: import from a CSV file for complete mapping that's easy to manage.
  @@CurrencyHash = {
    USD: "$",
    EUR: "€",
    GBP: "£",
    INR: " ",
    CAD: "$",
    AUD: "$",
    ZAR: "R",
    NZD: "$",
    JPY: "¥"
  }


  def find_currency_code(money)
    # Return nothing if nothing's really there.
    return nil if money == "" || money == nil
    textinmoney = money.to_s.gsub(/[^\D]/, "").upcase.strip
    return nil if textinmoney == "" || textinmoney == nil

    # If the money is already a Currency object, just return the attribute
    return money.currency if money.class == Currency

    # Prefer 3-letter abbreviation since it's exact.
    return textinmoney if @@CurrencyHash.has_key?(textinmoney.to_sym)

    # Map symbol to 3-letter abbreviation
    # This will return the first key it finds that matches the value.
    # There should be a warning provided when assuming this much.
    return @@CurrencyHash.key(textinmoney)

  end

  def initialize(amount, currencycode = nil)
    # Was currency code provided? If not, let's try to find it.
    currencycode ? self.currency = find_currency_code(currencycode) : self.currency = find_currency_code(amount)
    self.amount = amount
  end

  # Validate the currency and clean it up.
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

  # Validate the amount and clean it up.
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
    "#{@@CurrencyHash[@currency.to_sym]}#{sprintf "%.2f" % @amount} #{@currency}"
  end

  def ==(money)
    money.is_a?(Currency) ? moneyObj = money : moneyObj = Currency.new(money) rescue false
    return false unless moneyObj
    self.to_s == moneyObj.to_s
  end

  def +(money)
    currencycode = find_currency_code(money)
    currencycode && money.is_a?(Currency) ? moneyObj = money : moneyObj = Currency.new(money, self.currency)
    raise DifferentCurrencyCodeError, "Cannot add different currencies" unless self.currency == moneyObj.currency
    Currency.new(self.amount + moneyObj.amount, self.currency)
  end

  def -(money)
    currencycode = find_currency_code(money)
    currencycode && money.is_a?(Currency) ? moneyObj = money : moneyObj = Currency.new(money, self.currency)
    raise DifferentCurrencyCodeError, "Cannot subtract different currencies" unless self.currency == moneyObj.currency
    Currency.new(self.amount - moneyObj.amount, self.currency)
  end

  def *(money)
    currencycode = find_currency_code(money)
    currencycode && money.is_a?(Currency) ? moneyObj = money : moneyObj = Currency.new(money, self.currency)
    raise DifferentCurrencyCodeError, "Cannot multiply different currencies" unless self.currency == moneyObj.currency
    Currency.new(self.amount * moneyObj.amount, self.currency)
  end
end





