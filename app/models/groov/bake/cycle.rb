class Groov::Bake::Cycle < ApplicationRecord

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

  # Enumerations.
  enum oven_type: {
    grieve_iao: 1,
    jpw_iao: 2,
    large_oven: 3,
    small_oven: 4
  }, _prefix: true

  # Associations.
  belongs_to  :user,
              class_name: "::User",
              foreign_key: "user_id",
              optional: true
	has_many	:shop_orders,
            class_name: "Groov::Bake::ShopOrder",
            foreign_key: "cycle_id",
            inverse_of: :cycle,
            dependent: :destroy

  # Validations.
  validates :oven_type,
            presence: true
  validates :setpoint, :minimum, :maximum, :soak_length, :bakestand_number, :rod_cart_number,
            numericality: { only_integer: true, greater_than: 0 },
            allow_blank: true

  # Scopes.
  scope :pre_bake, -> { where(loading_finished_at: nil) }
  scope :post_bake, -> { where.not(cycle_ended_at: nil) }
  scope :baking_now, -> { where.not(loading_finished_at: nil).where(cycle_ended_at: nil) }
  scope :by_cycle_started, -> { order(:cycle_started_at) }
  scope :by_cycle_ended, -> { order(cycle_ended_at: :desc) }

  # Callbacks.

  # Instance methods.

  # Returns whether cycle has bakestand.
  def has_bakestand?
    return self.shop_orders.container_type_trays.length > 0
  end

  # Returns whether cycle has rod cart.
  def has_rod_cart?
    return self.shop_orders.container_type_rods.length > 0
  end

  # Updates cycle bake parameters after shop order added.
  def update_parameters
    if self.shop_orders.length == 0
      self.bake_profile = nil
      self.setpoint = nil
      self.minimum = nil
      self.maximum = nil
      self.soak_length = nil
    else
      case self.oven_type
      when "grieve_iao", "jpw_iao"
        self.bake_profile = self.shop_orders.first.bake_profile
        self.setpoint = self.shop_orders.first.setpoint
        self.minimum = self.shop_orders.first.minimum
        self.maximum = self.shop_orders.first.maximum
        self.soak_length = self.shop_orders.first.soak_length
      else
        self.bake_profile = nil
        self.minimum = self.shop_orders.maximum(:minimum)
        self.maximum = self.shop_orders.minimum(:maximum)
        self.soak_length = self.shop_orders.maximum(:soak_length)
        self.setpoint = ((self.minimum + self.maximum) / 2.0).to_i
      end
    end
    self.save
  end

  # Returns timestamp for start of graph.
  def chart_start
    ts = self.cycle_started_at - 2.minutes
    return ts.strftime("%s").to_i * 1000
  end

  # Returns timestamp for end of graph.
  def chart_end
    ts = self.cycle_ended_at + 2.minutes
    return ts.strftime("%s").to_i * 1000
  end

  # Return PPI for chart graphics.
  def chart_graphic_ppi
    return 144.0
  end

  # Returns temperature chart height.
  def temperature_chart_height
    return case self.oven_type
           when "jpw_iao" then 3.25
           when "grieve_iao" then 3.25
           when "large_oven" then 4
           when "small_oven" then 4
           end
  end

  # Returns state chart height.
  def state_chart_height
    return case self.oven_type
           when "jpw_iao" then 0.75
           when "grieve_iao" then 0.75
           when "large_oven" then 0
           when "small_oven" then 0
           end
  end

  # Returns URL for temperature/pressure graph.
  def temperature_chart_url
    return "http://historian.varland.com/render/d-solo/Vv5-Rg87k/jpw-bakesheet-graphs?orgId=1&from=#{self.chart_start}&to=#{self.chart_end}&panelId=2&width=#{(self.chart_graphic_ppi * 8).to_i}&height=#{(self.chart_graphic_ppi * self.temperature_chart_height).to_i}&tz=America%2FNew_York&theme=light"
  end

  # Returns URL for state graph.
  def state_chart_url
    return "http://historian.varland.com/render/d-solo/Vv5-Rg87k/jpw-bakesheet-graphs?orgId=1&from=#{self.chart_start}&to=#{self.chart_end}&panelId=9&width=#{(self.chart_graphic_ppi * 8).to_i}&height=#{(self.chart_graphic_ppi * self.state_chart_height).to_i}&tz=America%2FNew_York&theme=light"
  end

  # Class methods.

end