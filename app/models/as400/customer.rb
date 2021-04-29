class As400::Customer < ApplicationRecord

  # Serialization.
  serialize :name

  # Associations.
  has_many  :parts

  # Validations.
  validates :code, :name,
            presence: true
  validates :code,
            format: { with: /\A[A-Z]{1,6}\z/ }

  # Class methods.

  # Method to create from AS400 JSON.
  def self.from_as400(code)
    as400 = self.as400_json(code)
    return nil if as400.blank? || !as400[:valid]
    attributes = {
      name: as400[:name]
    }
    create_with(attributes).find_or_create_by!(code: code)
  end

  # Method to lookup from AS400.
  def self.as400_json(code)
    uri = URI.parse("http://vcmsapi.varland.com/customer?customer=#{code}")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    return nil unless response.code.to_s == "200"
    return JSON.parse(response.body, symbolize_names: true)
  end

end