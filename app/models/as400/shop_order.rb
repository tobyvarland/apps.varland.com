class As400::ShopOrder < ApplicationRecord

  # Serialization.
  serialize :purchase_order
  serialize :customer_name
  serialize :part_name
  serialize :part_description
  serialize :process_spec
  serialize :equipment_used

  # Associations.
  has_many  :reject_tags,
            class_name: 'Quality::RejectTag'

  # Validations.
  validates :customer_code, :process_code, :part, :number, :customer_name, :part_name, :part_description, :process_spec, :received_on, :written_up_on, :pounds, :pieces, :schedule_code,
            presence: true
  validates :number,
            uniqueness: true

  # Callbacks.
  before_validation :get_from_as400

  # Instance methods.

  # Set reject tag count on System i.
  def set_as400_reject_tag_count
    return true
    #uri = URI.parse("http://vcmsapi.varland.com/set_reject_tag_count")
    #response = Net::HTTP.post_form(uri, shop_order: self.number, reject_tags: self.reject_tags.length)
    #return response.is_a?(Net::HTTPSuccess)
  end

  # Returns part spec fields.
  def part_spec
    fields = [self.customer_code, self.process_code, self.part]
    fields << self.sub unless self.sub.blank?
    return fields
  end

  # Retrieces properties from System i.
  def get_from_as400
    return if self.number.blank?
    # return unless self.customer_code.blank?
    as400 = As400::ShopOrder.as400_json(self.number)
    return if as400.blank? || !as400[:valid]
    self.customer_code = as400[:customer]
    self.process_code = as400[:process]
    self.part = as400[:part]
    self.sub = as400[:sub]
    self.schedule_code = as400[:schedule_code]
    self.customer_name = as400[:customer_name]
    self.part_name = as400[:part_name]
    self.part_description = as400[:part_description]
    self.process_spec = as400[:process_spec]
    self.purchase_order = as400[:purchase_order]
    self.received_on = as400[:received_on]
    self.written_up_on = as400[:written_up_on]
    self.pounds = as400[:pounds]
    self.pieces = as400[:pieces]
    self.container_count = as400[:containers]
    self.container_type = as400[:container_type]
    self.equipment_used = as400[:equipment_used]
    self.received_at = as400[:received_at]
  end

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
      schedule_code: as400[:schedule_code],
      customer_name: as400[:customer_name],
      part_name: as400[:part_name],
      part_description: as400[:part_description],
      process_spec: as400[:process_spec],
      purchase_order: as400[:purchase_order],
      received_on: as400[:received_on],
      written_up_on: as400[:written_up_on],
      pounds: as400[:pounds],
      pieces: as400[:pieces],
      container_count: as400[:containers],
      container_type: as400[:container_type],
      equipment_used: as400[:equipment_used],
      received_at: as400[:received_at]
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