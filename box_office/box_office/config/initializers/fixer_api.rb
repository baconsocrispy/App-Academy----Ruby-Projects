class FixerAPI
  include HTTParty

  BASE_URL = 'http://data.fixer.io/api/'
  API_PARTIAL_URL = "?access_key=#{ENV['FIXER_IO_API_KEY']}"

  def self.update_rate_store
    latest_rates = latest
    iso_to = latest_rates['base']
    latest_rates['rates'].each { |iso_from, rate| ExchangeRate.add_rate(iso_from, iso_to, (1 / rate) )}
    true
  end

  private
  # set args[:base] to base currency of choice if other than USD; NEED TO UPGRADE ACCESS FOR THIS FEATURE
  # To limit request to certain fx: args[:symbols] = string of symbols i.e. 'USD,EUR,AUD,CAD'
  def self.latest(args = {})
    args[:base] ||= 'EUR'
    args[:symbols] ||= ''
    request = HTTParty.get(BASE_URL + "latest&base=#{args[:base]}&symbols=#{args[:symbols]}" + API_PARTIAL_URL).to_json
    @request_hash = JSON.parse(request)
  end
end

