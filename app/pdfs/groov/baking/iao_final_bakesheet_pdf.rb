require "open-uri"

class Groov::Baking::IAOFinalBakesheetPdf < ::VarlandPdf

  def initialize(cycle)
    super()
    @cycle = cycle
    self.print_data
  end

  def print_data

    # Draw logo & title.
    self.logo(0.5, 10.5, 7.5, 0.5, h_align: :left, variant: :mark)
    self.txtb("IAO Bakesheet", 1.1, 10.5, 6.75, 0.5, h_align: :left, style: :bold, transform: :uppercase, size: 24)

    # Download and add Grafana charts.
    self.image(open(@cycle.temp_pressure_chart_url), at: [0.5.in, 9.75.in], width: 7.5.in, height: 3.75.in)
    self.image(open(@cycle.state_chart_url), at: [0.5.in, 6.in], width: 7.5.in, height: 1.5.in)
    self.rect(0.5, 9.75, 7.5, 5.25)

    # Print bake cycle details.
    y = 4.25
    self.txtb("Bake Cycle Details", 0.5, y, 8, 0.25, h_align: :left, v_align: :top, style: :bold, transform: :uppercase, size: 12)
    y -= 0.25
    self.txtb("Oven:", 0.5, y, 8, 0.25, h_align: :left, v_align: :top)
    self.txtb(@cycle.oven, 1, y, 8, 0.25, h_align: :left, v_align: :top, style: :bold)
    y -= 0.2
    self.txtb("Profile:", 0.5, y, 8, 0.25, h_align: :left, v_align: :top)
    self.txtb("#{@cycle.profile_name}\n<font size=\"8\">#{@cycle.setpoint}º F (#{@cycle.minimum}º F / #{@cycle.maximum}º F), #{(@cycle.soak_length / 60.0)} HR</font>", 1, y, 8, 0.25, h_align: :left, v_align: :top, style: :bold)
    y = 4
    self.txtb("Cycle Started:", 3, y, 8, 0.25, h_align: :left, v_align: :top)
    self.txtb(@cycle.cycle_started_at.strftime("%m/%d/%y %I:%M%P"), 4, y, 8, 0.25, h_align: :left, v_align: :top, style: :bold)
    y -= 0.2
    self.txtb("Purge Ended:", 3, y, 8, 0.25, h_align: :left, v_align: :top)
    self.txtb(@cycle.purge_ended_at.strftime("%m/%d/%y %I:%M%P"), 4, y, 8, 0.25, h_align: :left, v_align: :top, style: :bold)
    y -= 0.2
    self.txtb("Soak Started:", 3, y, 8, 0.25, h_align: :left, v_align: :top)
    self.txtb(@cycle.soak_started_at.strftime("%m/%d/%y %I:%M%P"), 4, y, 8, 0.25, h_align: :left, v_align: :top, style: :bold)
    y = 4
    self.txtb("Soak Ended:", 5.5, y, 8, 0.25, h_align: :left, v_align: :top)
    self.txtb(@cycle.soak_ended_at.strftime("%m/%d/%y %I:%M%P"), 6.5, y, 8, 0.25, h_align: :left, v_align: :top, style: :bold)
    y -= 0.2
    self.txtb("Gas Off:", 5.5, y, 8, 0.25, h_align: :left, v_align: :top)
    self.txtb(@cycle.gas_off_at.strftime("%m/%d/%y %I:%M%P"), 6.5, y, 8, 0.25, h_align: :left, v_align: :top, style: :bold)
    y -= 0.2
    self.txtb("Cycle Ended:", 5.5, y, 8, 0.25, h_align: :left, v_align: :top)
    self.txtb(@cycle.cycle_ended_at.strftime("%m/%d/%y %I:%M%P"), 6.5, y, 8, 0.25, h_align: :left, v_align: :top, style: :bold)

    # Print order details.
    y = 3.25
    self.txtb("Shop Order Details", 0.5, y, 8, 0.25, h_align: :left, v_align: :top, style: :bold, transform: :uppercase, size: 12)
    y -= 0.25
    self.txtb("S.O. #", 0.5, y, 0.75, 0.25, h_align: :center, v_align: :center, style: :bold, line_color: "000000", fill_color: "dddddd")
    self.txtb("Part Spec", 1.25, y, 3, 0.25, h_align: :left, h_pad: 0.1, v_align: :center, style: :bold, line_color: "000000", fill_color: "dddddd")
    self.txtb("Loads", 4.25, y, 1.5, 0.25, h_align: :left, h_pad: 0.1, v_align: :center, style: :bold, line_color: "000000", fill_color: "dddddd")
    @cycle.shop_orders.each do |shop_order|
      y -= 0.25
      self.txtb(shop_order.shop_order.number, 0.5, y, 0.75, 0.25, size: 8, h_align: :center, v_align: :center, line_color: "000000")
      self.txtb(shop_order.shop_order.part_spec.join(" / "), 1.25, y, 3, 0.25, size: 8, h_align: :left, h_pad: 0.1, v_align: :center, line_color: "000000")
      self.txtb(shop_order.load_numbers, 4.25, y, 1.5, 0.25, size: 8, h_align: :left, h_pad: 0.1, v_align: :center, line_color: "000000")
    end

  end

end