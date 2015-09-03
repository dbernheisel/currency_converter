#!/usr/bin/env ruby

class Currency

  attr_accessor :currency
  attr_accessor :amount

  # Source http://www.xe.com/symbols.php
  @@CurrencySymbols = %w|Lek ؋ $ ƒ ман p. BZ$ $b KM P лв R$ ៛ ¥ ₡ kn ₱ Kč kr RD$ £ € ¢ Q L Ft Rp ﷼ ₪ J$ ₩ ₭ Ls Lt ден RM ₨ ₮ MT C$ ₦ B/. Gs S/. zł lei руб Дин. S R CHF NT$ ฿ TT$ ₤ ₴ $U Bs ₫ Z$|
  @@CurrencyAbbreviations = %w|ALL AFN ARS AWG AUD AZN BSD BBD BYR BZD BMD BOB BAM BWP BGN BRL BND KHR CAD KYD CLP CNY COP CRC HRK CUP CZK DKK DOP XCD EGP SVC EEK EUR FKP FJD GHC GIP GTQ GGP GYD HNL HKD HUF ISK INR IDR IRR IMP ILS JMD JPY JEP KZT KPW KRW KGS LAK LVL LBP LRD LTL MKD MYR MUR MXN MNT MZN NAD NPR ANG NZD NIO NGN NOK OMR PKR PAB PYG PEN PHP PLN QAR RON RUB SHP SAR RSD SCR SGD SBD SOS ZAR LKR SEK CHF SRD SYP TWD THB TTD TRY TRL TVD UAH GBP USD UYU UZS VEF VND YER ZWD|

  def initialize(amount, currencycode = nil)
    amount = amount.to_s.strip
    currencycode = @@CurrencySymbols.find { |symbol| amount.include?(symbol) } || @@CurrencyAbbreviations.find { |abb| amount.include?(abb) } if currencycode == nil
    amount = amount.gsub(/[^\d\.]/, "").to_f
    @currency = currencycode
    @amount = amount
  end

  def to_s
    "#{sprintf "%.2f" % @amount} #{@currency}"
  end

  def ==(money)
    moneyObj = Currency.new(money) rescue false
    #puts moneyObj, self, money
    begin
      return false if moneyObj.class != Currency
      self.to_s == moneyObj.to_s
    rescue
      return false
    end
  end

  def +(money)
    begin
      Float(money)
    rescue
      raise DifferentCurrencyCodeError, "Cannot add different currencies" unless self.currency == money.currency
      Currency.new(self.amount + money.amount, self.currency) if self.currency == money.currency
    else
      Currency.new(self.amount + money, self.currency)
    end
  end

  def -(money)
    begin
      Float(money)
    rescue
      raise DifferentCurrencyCodeError, "Cannot subtract different currencies" unless self.currency == money.currency
      Currency.new(self.amount - money.amount, self.currency) if self.currency == money.currency
    else
      Currency.new(self.amount - money, self.currency)
    end
  end

  def *(money)
    begin
      Float(money)
    rescue
      raise DifferentCurrencyCodeError, "Cannot multiply different currencies" unless self.currency == money.currency
      Currency.new(self.amount * money.amount, self.currency) if self.currency == money.currency
    else
      Currency.new(self.amount * money, self.currency)
    end
  end

end





