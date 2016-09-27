# creditcardutils

[![Build Status](https://travis-ci.org/faaez/creditcardutils.svg?branch=master)](https://travis-ci.org/faaez/creditcardutils)
![Dependencies](https://david-dm.org/faaez/creditcardutils.svg)

[![npm](https://nodei.co/npm/creditcardutils.png)](https://npmjs.org/package/creditcardutils)

A general purpose javascript library for credit card number validation and formatting. Based on [`jondavidjohn/payform`](https://github.com/jondavidjohn/payform) and [`jquery.payment`](https://github.com/stripe/jquery.payment). Usable in React Native and Node. 

Supported card types:

* Visa
* MasterCard
* American Express
* Diners Club
* Discover
* UnionPay
* JCB
* Visa Electron
* Maestro
* Forbrugsforeningen
* Dankort

(Custom card types are also [supported](#custom-cards))

## Installation / Usage

### npm (Node and Browserify)

```sh
npm install creditcardutils --save
```

```javascript
var creditcardutils = require('creditcardutils');

// Format input for card number 
creditcardutils.formatCardNumber(input); //=> returns formatted card number

// Validate a credit card number
creditcardutils.validateCardNumber('4242 4242 4242 4242'); //=> true

// Get card type from number
creditcardutils.parseCardType('4242 4242 4242 4242'); //=> 'visa'
```

## API

### General Formatting and Validation

#### creditcardutils.formatCardNumber(input)

Formats card numbers:

* Includes a space between every 4 digits
* Restricts input to numbers
* Limits to 16 numbers
* Supports American Express formatting

Example:

``` javascript
creditcardutils.formatCardExpiry(input); //=>returns formatted card expiry date
```
#### creditcardutils.formatCardExpiry(input)

Formats expiry date:

* Includes a forward slash between month and year

Example:

``` javascript
creditcardutils.formatCardExpiry(input); //=>returns formatted card expiry date
```

#### creditcardutils.validateCardNumber(number)

Validates a card number:

* Validates numbers
* Validates Luhn algorithm
* Validates length

Example:

``` javascript
creditcardutils.validateCardNumber('4242 4242 4242 4242'); //=> true
```

#### creditcardutils.validateCardExpiry(month, year)

Validates a card expiry:

* Validates numbers
* Validates in the future
* Supports year shorthand

Example:

``` javascript
creditcardutils.validateCardExpiry('05', '20'); //=> true
creditcardutils.validateCardExpiry('05', '2015'); //=> true
creditcardutils.validateCardExpiry('05', '05'); //=> false
```

#### creditcardutils.validateCardCVC(cvc, type)

Validates a card CVC:

* Validates number
* Validates length to 4

Example:

``` javascript
creditcardutils.validateCardCVC('123'); //=> true
creditcardutils.validateCardCVC('123', 'amex'); //=> true
creditcardutils.validateCardCVC('1234', 'amex'); //=> true
creditcardutils.validateCardCVC('12344'); //=> false
```

#### creditcardutils.parseCardType(number)

Returns a card type. Either:

* `visa`
* `mastercard`
* `amex`
* `dinersclub`
* `discover`
* `unionpay`
* `jcb`
* `visaelectron`
* `maestro`
* `forbrugsforeningen`
* `dankort`

The function will return `null` if the card type can't be determined.

Example:

``` javascript
creditcardutils.parseCardType('4242 4242 4242 4242'); //=> 'visa'
creditcardutils.parseCardType('hello world?'); //=> null
```

#### creditcardutils.parseCardExpiry(string)

Parses a credit card expiry in the form of MM/YYYY, returning an object containing the `month` and `year`. Shorthand years, such as `13` are also supported (and converted into the longhand, e.g. `2013`).

``` javascript
creditcardutils.parseCardExpiry('03 / 2025'); //=> {month: 3: year: 2025}
creditcardutils.parseCardExpiry('05 / 04'); //=> {month: 5, year: 2004}
```

This function doesn't perform any validation of the month or year; use `creditcardutils.validateCardExpiry(month, year)` for that.

### Custom Cards

#### creditcardutils.cards

Array of objects that describe valid card types. Each object should contain the following fields:

``` javascript
{
  // Card type, as returned by creditcardutils.parseCardType.
  type: 'mastercard',
  // Regex used to identify the card type. For the best experience, this should be
  // the shortest pattern that can guarantee the card is of a particular type.
  pattern: /^5[0-5]/,
  // Array of valid card number lengths.
  length: [16],
  // Array of valid card CVC lengths.
  cvcLength: [3],
  // Boolean indicating whether a valid card number should satisfy the Luhn check.
  luhn: true,
  // Regex used to format the card number. Each match is joined with a space.
  format: /(\d{1,4})/g
}
```

When identifying a card type, the array is traversed in order until the card number matches a `pattern`. For this reason, patterns with higher specificity should appear towards the beginning of the array.

## Built with creditcardutils
<table>
<tr>
<td align="center"><a href="http://gopheo.com"><img src="https://s3.amazonaws.com/pheo-assets/web-app/desktop_footer.png" height="64" /></a></td>
</tr>
<tr>
<td align="center">Crisp</td>
<td align="center"><a href="https://crisp.im/"><img src="https://avatars0.githubusercontent.com/u/16270189?v=3&s=200" height="64" /></a></td>
</tr>
<tr>
<td align="center">Crisp</td>
</tr>
</table>

## Development

Please see [CONTRIBUTING.md](https://github.com/faaez/creditcardutils/blob/develop/CONTRIBUTING.md).
