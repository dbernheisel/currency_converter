# Currency Converter

![Image of Troll Money](https://pbs.twimg.com/media/CCAuPRJWAAAFjZk.jpg:large)

## Features
- Currency class that holds amounts, currency code, and validations.
- CurrencyConverter class that handles a conversion between two Currency objects with a given exchange rate table.
- CurrencyTrader class that handles analysis between different exchange rates over time.

## Usage
- At your bash terminal, run `ruby trade_currency.rb` and it will output some tests to screen.
- Create a new Currency object: `Currency.new("$100")` or `Currency.new(100, :USD)`
- Handle Currency instances easily for simple math, eg `(Currency.new("$100") + Currency.new("$100")).to_s => $200 USD`
- Convert currencies. Create a new CurrencyConverter instance and pass it the exchange rate hash:
```
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
converter = CurrencyConverter.new(currency_rates_20150903)
converter.convert(Currency.new("$100"), :EUR) => €89
```
- Analyze different exchange rates, and source currency code. Create a CurrencyTrader instance `CurrencyTrader.new([currency_rates1, currency_rates2, currency_rates3], :USD)`

- CurrencyTrader methods avaiable:
```
.best_currency(earlier_conversion, later_conversion) => :USD
.profit_in_trade(earlier_conversion, later_conversion) => 1.8
.best_currency_path => [:USD, :GBP, :JPY, etc]
.best_currency_amount => $100000
.give_advice => {1: [olddate, newdate, currency, profit], 2: [olddate, newdate, currency, profit], etc}
```
Sample output of give_advice after some formatting:
```
On 09/03/15 trade to JPY and trade back on 09/04/15 and you'll make $1.20 USD
On 09/04/15 trade to GBP and trade back on 09/07/15 and you'll make $0.00 USD
On 09/07/15 trade to EUR and trade back on 09/11/15 and you'll make $0.80 USD
```



## License
The MIT License (MIT)

Copyright (c) 2015 David Bernheisel

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
