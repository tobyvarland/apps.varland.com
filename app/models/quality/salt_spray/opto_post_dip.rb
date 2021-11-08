class Quality::SaltSpray::OptoPostDip < ApplicationRecord

  # Concerns.
  include ShopOrderAssignable

  # Associations.
  belongs_to  :shop_order,
              class_name: 'AS400::ShopOrder'

  # Validations.
  validates :post_dip_at, :vat, :description, :load, :dip_seconds,
            presence: true
  validates :load,
            numericality: { only_integer: true, greater_than: 0 }
  validates :dip_seconds,
            numericality: { greater_than: 0 }

  # Callbacks.
  before_validation :set_timestamp
  before_validation :get_from_as400

  # Instance methods.

  # Sets timestamp if not previously set.
  def set_timestamp
    self.post_dip_at = Time.current if self.post_dip_at.blank?
  end

  # Retrieces properties from System i.
  def get_from_as400
    return if self.vat.blank?
    as400 = Quality::SaltSpray::OptoPostDip.as400_json(self.vat)
    return if as400.blank? || !as400[:valid]
    self.description = as400[:description]
  end

  # Class methods.

  # Method to lookup from AS400.
  def self.as400_json(code)
    uri = URI.parse("http://vcmsapi.varland.com/vat?code=#{code}")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    return nil unless response.code.to_s == "200"
    return JSON.parse(response.body, symbolize_names: true)
  end

end