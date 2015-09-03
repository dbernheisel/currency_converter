#!/usr/bin/env ruby

class Currency

  attr_accessor :currency
  attr_accessor :amount

  # Source http://www.xe.com/symbols.php
  @@CurrencySymbols = %w|Lek ؋ $ ƒ ман p. BZ$ $b KM P лв R$ ៛ ¥ ₡ kn ₱ Kč kr RD$ £ € ¢ Q L Ft Rp ﷼ ₪ J$ ₩ ₭ Ls Lt ден RM ₨ ₮ MT C$ ₦ B/. Gs S/. zł lei руб Дин. S R CHF NT$ ฿ TT$ ₤ ₴ $U Bs ₫ Z$|
  @@CurrencyAbbreviations = %w|ALL AFN ARS AWG AUD AZN BSD BBD BYR BZD BMD BOB BAM BWP BGN BRL BND KHR CAD KYD CLP CNY COP CRC HRK CUP CZK DKK DOP XCD EGP SVC EEK EUR FKP FJD GHC GIP GTQ GGP GYD HNL HKD HUF ISK INR IDR IRR IMP ILS JMD JPY JEP KZT KPW KRW KGS LAK LVL LBP LRD LTL MKD MYR MUR MXN MNT MZN NAD NPR ANG NZD NIO NGN NOK OMR PKR PAB PYG PEN PHP PLN QAR RON RUB SHP SAR RSD SCR SGD SBD SOS ZAR LKR SEK CHF SRD SYP TWD THB TTD TRY TRL TVD UAH GBP USD UYU UZS VEF VND YER ZWD|

  def find_currency_code(money)
    @@CurrencySymbols.find { |symbol| money.include?(symbol) } || @@CurrencyAbbreviations.find { |abb| money.include?(abb) }
  end

  def initialize(amount, currencycode = nil)
    amount = amount.to_s.strip
    currencycode ? currencycode = currencycode : currencycode = find_currency_code(amount)

    amount = amount.gsub(/[^\d\.]/, "")
    raise NoAmountCodeError("Cannot determine amount") if amount == ""
    @amount = amount.to_f

    raise NoCurrencyCodeError("Cannot determine currency code of amount") if !currencycode
    @currency = currencycode

  end

  def to_s
    "#{@currency}#{sprintf "%.2f" % @amount}"
  end

  def ==(money)
    if money.class == Currency
      moneyObj = money
    else
      moneyObj = Currency.new(money) rescue false
    end
    return false unless moneyObj
    self.to_s == moneyObj.to_s
  end

  def +(money)
    money.class == Currency ? currencycode = money.currency : currencycode = find_currency_code(money.to_s)
    currencycode ? moneyObj = Currency.new(money) : moneyObj = Currency.new(money, self.currency)
    raise DifferentCurrencyCodeError("Cannot add different currencies") unless self.currency == moneyObj.currency
    Currency.new(self.amount + moneyObj.amount, self.currency) if self.currency == moneyObj.currency
  end

  def -(money)
    money.class == Currency ? currencycode = money.currency : currencycode = find_currency_code(money.to_s)
    currencycode ? moneyObj = Currency.new(money) : moneyObj = Currency.new(money, self.currency)
    raise DifferentCurrencyCodeError("Cannot subtract different currencies") unless self.currency == moneyObj.currency
    Currency.new(self.amount - moneyObj.amount, self.currency) if self.currency == moneyObj.currency
  end

  def *(money)
    money.class == Currency ? currencycode = money.currency : currencycode = find_currency_code(money.to_s)
    currencycode ? moneyObj = Currency.new(money) : moneyObj = Currency.new(money, self.currency)
    raise DifferentCurrencyCodeError("Cannot multiply different currencies") unless self.currency == moneyObj.currency
    Currency.new(self.amount * moneyObj.amount, self.currency) if self.currency == moneyObj.currency
  end

end





