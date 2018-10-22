# frozen_string_literal: true

MoneyRails.configure do |config|
  config.register_currency = {
    priority:            1,
    iso_code:            'EU2',
    name:                'Euro with subunit of 2 digits',
    symbol:              '€',
    symbol_first:        false,
    subunit:             'Subcent',
    subunit_to_unit:     100,
    thousands_separator: ' ',
    decimal_mark:        ','
  }

  config.default_currency = 'EU2' # or :gbp, :usd, etc.
  config.no_cents_if_whole = false
end
