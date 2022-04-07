class Groov::Baking::Cycle < ApplicationRecord

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

  # Associations.
	has_many	:shop_orders,
            class_name: "Groov::Baking::ShopOrder",
            foreign_key: "cycle_id",
            inverse_of: :cycle,
            dependent: :destroy

  # Validations.
  validates :bake_type,
            presence: true
  validates :setpoint, :minimum, :maximum, :soak_length,
            numericality: { only_integer: true, greater_than: 0 },
            allow_blank: true

  # Instance methods.

  # Returns timestamp for start of graph.
  def chart_start
    ts = self.cycle_started_at - 5.minutes
    return ts.strftime("%s").to_i * 1000
  end

  # Returns timestamp for end of graph.
  def chart_end
    ts = self.cycle_ended_at + 5.minutes
    return ts.strftime("%s").to_i * 1000
  end

  # Return PPI for chart graphics.
  def chart_graphic_ppi
    return 144.0
  end

  # Returns URL for temperature/pressure graph.
  def temp_pressure_chart_url
    return "http://historian.varland.com/render/d-solo/Vv5-Rg87k/jpw-bakesheet-graphs?orgId=1&from=#{self.chart_start}&to=#{self.chart_end}&panelId=2&width=#{(self.chart_graphic_ppi * 7.5).to_i}&height=#{(self.chart_graphic_ppi * 3.75).to_i}&tz=America%2FNew_York&theme=light"
  end

  # Returns URL for state graph.
  def state_chart_url
    return "http://historian.varland.com/render/d-solo/Vv5-Rg87k/jpw-bakesheet-graphs?orgId=1&from=#{self.chart_start}&to=#{self.chart_end}&panelId=9&width=#{(self.chart_graphic_ppi * 7.5).to_i}&height=#{(self.chart_graphic_ppi * 1.5).to_i}&tz=America%2FNew_York&theme=light"
  end

end