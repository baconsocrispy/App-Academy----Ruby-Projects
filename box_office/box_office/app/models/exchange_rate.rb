class ExchangeRate < ApplicationRecord
  validates :iso_to, :iso_from, :rate, presence: true
  # ADD UNIQUENESS to iso_to & iso_from

  def self.add_rate(iso_from, iso_to, rate)
    rate_exists?(iso_from, iso_to) ? update_rate(iso_from, iso_to, rate) : new_rate(iso_from, iso_to, rate)
  end
  def self.get_rate(iso_from, iso_to)
    rate = find_by(iso_from: iso_from, iso_to: iso_to)
    rate.rate
  end
  def self.each_rate
    return find_each unless block_given?
    find_each { |rate| yield rate.iso_from, rate.iso_to, rate.rate }
  end
  # NEED TO READ UP ON TRANSACTIONS
  # def self.transaction(&block)

  # end
  # NEED TO READ UP ON MARSHAL module
  # def marshal_dump

  # end


  private
  def self.update_rate(iso_from, iso_to, new_rate)
    rate = find_by(iso_from: iso_from, iso_to: iso_to)
    rate.rate = new_rate
    rate.save!
  end
  def self.rate_exists?(iso_from, iso_to)
    ExchangeRate.where(iso_to: iso_to, iso_from: iso_from).exists?
  end
  def self.new_rate(iso_from, iso_to, fx_rate)
    raise 'Invalid ISO Code!' if !valid_isos?(iso_from, iso_to)
    rate = ExchangeRate.new
    rate.iso_to = iso_to
    rate.iso_from = iso_from
    rate.rate = fx_rate
    rate.save!
  end
  def self.valid_isos?(*isos)
    codes = *isos
    codes.each { |iso| return false if !valid_iso?(iso) }
    true
  end
  def self.valid_iso?(iso)
    File.foreach("#{Rails.root}/lib/iso_codes.txt").grep(/#{iso}/).any?
  end
end
