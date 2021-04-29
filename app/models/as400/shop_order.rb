class As400::ShopOrder < ApplicationRecord

  # Serialization.
  serialize :purchase_order

  # Associations.
  belongs_to  :part

  # Validations.
  validates :number, :containers, :container_type, :received_on, :written_up_on, :pounds, :pieces,
            presence: true

  # Class methods.

  # Method to create from AS400 JSON.
  def self.from_as400(number)
    as400 = self.as400_json(number)
    return nil if as400.blank? || !as400[:valid]
    attributes = {
      purchase_order: as400[:purchase_order],
      containers: as400[:containers],
      container_type: as400[:container_type],
      received_on: as400[:received_on],
      written_up_on: as400[:written_up_on],
      promised_on: as400[:promised_on],
      pounds: as400[:pounds],
      pieces: as400[:pieces],
      status: as400[:status],
      inspected_on: as400[:inspected_on],
      inspected_by: as400[:inspected_by]
    }
    create_with(attributes).find_or_create_by!(part: As400::Part.from_as400(as400[:customer], as400[:process], as400[:part], as400[:sub]), number: number)
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