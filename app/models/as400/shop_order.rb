class As400::ShopOrder < ApplicationRecord

  # Serialization.
  serialize :purchase_order
  serialize :customer_name
  serialize :part_name
  serialize :part_description
  serialize :process_spec

  # Validations.
  validates :customer_code, :process_code, :part, :number, :customer_name, :part_name, :part_description, :process_spec, :received_on, :written_up_on, :pounds, :pieces,
            presence: true

  # Class methods.

  # Method to create from AS400 JSON.
  def self.from_as400(number)
    as400 = self.as400_json(number)
    return nil if as400.blank? || !as400[:valid]
    attributes = {
      customer_code: as400[:customer],
      process_code: as400[:process],
      part: as400[:part],
      sub: as400[:sub],
      customer_name: as400[:customer_name],
      part_name: as400[:part_name],
      part_description: as400[:part_description],
      process_spec: as400[:process_spec],
      purchase_order: as400[:purchase_order],
      received_on: as400[:received_on],
      written_up_on: as400[:written_up_on],
      pounds: as400[:pounds],
      pieces: as400[:pieces]
    }
    create_with(attributes).find_or_create_by!(number: number)
  end

  # Method to lookup from AS400.
  def self.as400_json(number)
    uri = URI.parse("http://vcmsapi.varland.com/shop_order?shop_order=#{number}")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    return nil unless response.code.to_s == "200"
    return JSON.parse(response.body, symbolize_names: true)
  end

end