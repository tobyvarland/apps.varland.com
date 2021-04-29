class As400::Part < ApplicationRecord

  # Serialization.
  serialize :name
  serialize :process_spec
  serialize :description

  # Associations.
  belongs_to  :customer
  has_many    :shop_orders

  # Validations.
  validates :process, :part, :control_number, :name, :process_spec, :description, :square_feet, :piece_weight, :pounds_per_cubic,
            presence: true

  # Class methods.

  # Method to create from AS400 JSON.
  def self.from_as400(customer, process, part, sub)
    as400 = self.as400_json(customer, process, part, sub)
    return nil if as400.blank? || !as400[:valid]
    attributes = {
      control_number: as400[:control_number],
      name: as400[:name],
      process_spec: as400[:process_spec],
      description: as400[:description],
      square_feet: as400[:square_feet],
      piece_weight: as400[:piece_weight],
      pounds_per_cubic: as400[:pounds_per_cubic]
    }
    create_with(attributes).find_or_create_by!(customer: As400::Customer.from_as400(customer), process: process, part: part, sub: sub)
  end

  # Method to lookup from AS400.
  def self.as400_json(customer, process, part, sub)
    uri = URI.parse("http://vcmsapi.varland.com/part?customer=#{customer}&process=#{process}&part=#{part}&sub=#{sub}")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    return nil unless response.code.to_s == "200"
    return JSON.parse(response.body, symbolize_names: true)
  end

end