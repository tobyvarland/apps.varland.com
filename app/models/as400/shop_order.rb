class AS400::ShopOrder < ApplicationRecord

  # Use FriendlyID.
  extend FriendlyId
  friendly_id :number, use: :slugged

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
  has_many  :trico_bins,
            class_name: 'Shipping::TricoBin'

  # Validations.
  validates :customer_code, :process_code, :part, :number, :customer_name, :part_name, :part_description, :process_spec, :received_on, :written_up_on, :piece_weight, :pounds, :pieces, :schedule_code,
            presence: true
  validates :number,
            uniqueness: true

  # Scopes.
  scope :trico_labels_not_printed, -> { where(printed_trico_labels: false) }

  # Callbacks.
  before_validation :get_from_as400

  # Instance methods.

  # Calculated pieces based on Trico bin weight.
  def trico_calculated_pieces
    return (self.trico_bin_total_weight / self.piece_weight).to_i
  end

  # # Prints Trico labels.
  # def print_trico_labels
  #   labels = []
  #   self.trico_bins.each do |bin|
  #     labels << {
  #       shop_order: self.number,
  #       part_number: self.part,
  #       po: self.purchase_order[0],
  #       pieces: bin.total_pieces,
  #       containers: self.container_count,
  #       container_type: self.container_type
  #     }
  #   end
  #   uri = URI.parse("http://vcmsapi.varland.com/print_trico_labels")
  #   response = Net::HTTP.post_form(uri, labels: ActiveSupport::JSON.encode(labels))
  #   self.printed_trico_labels = true
  #   self.save
  # end

  # Refresh Trico label information.
  def refresh_trico_labels
    self.get_from_as400
    self.save
    self.calculate_trico_bin_labels
  end

  # Returns if all Trico checks valid.
  def all_trico_checks_valid?
    self.is_valid_trico_order? && self.all_bin_weights_entered? && self.bin_weights_within_deviation_limit?
  end
  
  # Returns if all bin weights are within deviation limit.
  def bin_weights_within_deviation_limit?
    return self.trico_bin_total_weight_deviation.abs < 5
  end
  
  # Returns if all bin weights recorded and valid.
  def all_bin_weights_entered?
    return (self.trico_bins.length == self.container_count && self.trico_bins.where(scale_weight: 0).length == 0)
  end

  # Returns if valid Trico order.
  def is_valid_trico_order?
    return (self.customer_code == "TRIBRO")
  end

  # Return total weight of all Trico bins.
  def trico_bin_total_weight
    return self.trico_bins.sum(:scale_weight).to_f.round(2)
  end
  def trico_bin_total_pieces
    return self.trico_bins.sum("proportional_pieces + ifnull(fudge_pieces, 0)")
  end
  def trico_bin_total_weight_deviation
    return 100 * ((self.trico_bin_total_weight - self.pounds) / self.pounds)
  end

  # Perform calculations for Trico bin labeling.
  def calculate_trico_bin_labels

    return if self.trico_bins.length == 0

    # Calculate % of total weight and proportional pieces for each bin.
    total_weight = self.trico_bin_total_weight
    total_pieces_allocated = 0
    self.trico_bins.each do |bin|
      bin.percent_of_total = (bin.scale_weight / total_weight)
      bin.proportional_pieces = (self.pieces * bin.percent_of_total).to_i
      total_pieces_allocated += bin.proportional_pieces
    end

    # Add fudge pieces.
    fudge_pieces = self.pieces - total_pieces_allocated
    self.trico_bins.each do |bin|
      if bin.load_number <= fudge_pieces
        bin.fudge_pieces = 1
      else
        bin.fudge_pieces = 0
      end
      bin.save
    end

  end

  # Set reject tag count on System i.
  def set_as400_reject_tag_count
    uri = URI.parse("http://vcmsapi.varland.com/set_reject_tag_count")
    response = Net::HTTP.post_form(uri, shop_order: self.number, reject_tags: self.reject_tags.length)
    return response.is_a?(Net::HTTPSuccess)
  end

  # Returns part spec fields.
  def part_spec
    fields = [self.customer_code, self.process_code, self.part]
    fields << self.sub unless self.sub.blank?
    return fields
  end

  # Retrieves properties from System i.
  def get_from_as400
    return if self.number.blank?
    # return unless self.customer_code.blank?
    as400 = AS400::ShopOrder.as400_json(self.number)
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
    self.piece_weight = as400[:piece_weight]
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
      piece_weight: as400[:piece_weight],
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