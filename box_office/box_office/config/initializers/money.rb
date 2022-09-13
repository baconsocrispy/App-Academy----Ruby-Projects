MoneyRails.configure do |config|
  # To set the default currency
  #
  config.default_currency = :eur

  Money.default_bank = Money::Bank::VariableExchange.new(ExchangeRate)

  # Set default bank object
  #
  # Example:
  # config.default_bank = EuCentralBank.new

  # SET BANK TO CURRENCY LAYER
  # Might need to require 'money' and 'currencylayer'
  # bank = Money::Bank::Currencylayer.new { |n| n.round(4) }
  # bank.access_key = 'e8727eb7cd2ab2eb3dd58661c3f71cc3'
  # bank.update_rates

  # SET BANK TO EU CENTRAL BANK
  # bank = EuCentralBank.new
  # bank.update_rates

  # config.default_bank = bank
  # Add exchange rates to current money bank object.
  # (The conversion rate refers to one direction only)
  #
  # Example:
  # config.add_rate "USD", "CAD", 1.24515
  # config.add_rate "CAD", "USD", 0.803115

  # To handle the inclusion of validations for monetized fields
  # The default value is true
  #
  # config.include_validations = true

  # Default ActiveRecord migration configuration values for columns:
  #
  # config.amount_column = { prefix: '',           # column name prefix
  #                          postfix: '_cents',    # column name  postfix
  #                          column_name: nil,     # full column name (overrides prefix, postfix and accessor name)
  #                          type: :integer,       # column type
  #                          present: true,        # column will be created
  #                          null: false,          # other options will be treated as column options
  #                          default: 0
  #                        }
  #
  # config.currency_column = { prefix: '',
  #                            postfix: '_currency',
  #                            column_name: nil,
  #                            type: :string,
  #                            present: true,
  #                            null: false,
  #                            default: 'USD'
  #                          }

  # Register a custom currency
  #
  # Example:
  # config.register_currency = {
  #   priority:            1,
  #   iso_code:            "EU4",
  #   name:                "Euro with subunit of 4 digits",
  #   symbol:              "€",
  #   symbol_first:        true,
  #   subunit:             "Subcent",
  #   subunit_to_unit:     10000,
  #   thousands_separator: ".",
  #   decimal_mark:        ","
  # }

  # Specify a rounding mode
  # Any one of:
  
  # BigDecimal::ROUND_UP,
  # BigDecimal::ROUND_DOWN,
  # BigDecimal::ROUND_HALF_UP,
  # BigDecimal::ROUND_HALF_DOWN,
  # BigDecimal::ROUND_HALF_EVEN,
  # BigDecimal::ROUND_CEILING,
  # BigDecimal::ROUND_FLOOR
  #
  # set to BigDecimal::ROUND_HALF_EVEN by default
  #
  # config.rounding_mode = BigDecimal::ROUND_HALF_UP

  # Set default money format globally.
  # Default value is nil meaning "ignore this option".
  # Example:
  #
  # config.default_format = {
  #   no_cents_if_whole: nil,
  #   symbol: nil,
  #   sign_before_symbol: nil
  # }

  # FIXER.IO
  # Access Key: 6707027f0757e91ae30e2349376fa486
end