#!/usr/bin/env ruby

class Currency
  @currency
  @amount

  attr_accessor :currency
  attr_accessor :amount

  def initialize(currency, amount)
    @currency = currency
    @amount = amount
  end

  def to_s
    "#{currency}#{amount}"
  end

  def ==(money)
    return false if money.class != Currency
    (self.currency == money.currency) && (self.amount == money.amount)
  end

  def +(money)
    raise DifferentCurrencyCodeError, "Cannot add different currencies" unless self.currency == money.currency
    self.amount + money.amount if self.currency == money.currency
  end

  def -(money)
    raise DifferentCurrencyCodeError, "Cannot subtract different currencies" unless self.currency == money.currency
    self.amount - money.amount if self.currency == money.currency
  end
end