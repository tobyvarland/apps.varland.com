require "open-uri"

class Groov::Bake::BakesheetPdf < ::VarlandPdf

  BACKGROUND_COLORS = ['7be042', 'ff657f', '9cb5f2', 'ffc72d', 'b677ff', '73fdff', 'fca7ff', 'bdffd1', 'ffd6bd', 'dcecff']
  FOREGROUND_COLORS = ['000000', '000000', '000000', '000000', '000000', '000000', '000000', '000000', '000000', '000000']

  def initialize(cycle)
    super()
    @cycle = cycle
    self.print_data
  end

  def print_data
    @need_new_page = false
    self.print_oven_id_sheet if ["jpw_iao", "grieve_iao"].include?(@cycle.oven_type)
    self.print_bakestand_id_sheet if @cycle.has_bakestand?
    self.print_rod_cart_id_sheet if @cycle.has_rod_cart?
  end

  def print_bakestand_id_sheet

    # If need new page, create new page and clear flag.
    if @need_new_page
      self.start_new_page
      @need_new_page = false
    end

    # Draw header.
    self.logo 0.25,
              10.75,
              8,
              0.5,
              h_align: :left,
              variant: :mark
    self.txtb "Pre-Bake ID Sheet – Stand ##{@cycle.bakestand_number}",
              0.85,
              10.75,
              6.75,
              0.5,
              h_align: :left,
              style: :bold,
              transform: :uppercase,
              size: 20

    # Print bake cycle header.
    y = 10
    unless ["jpw_iao", "grieve_iao"].include?(@cycle.oven_type)
      self.print_bake_cycle_header(y)
      y -= 2
    end

    # Draw order table.
    self.print_order_table(y, "trays")

    # Determine bakestand options.
    top = 3.85
    left = 1.25
    column_count = 4
    row_count = 11
    if @cycle.oven_type == "small_oven"
      left = 2.75
      column_count = 2
      row_count = 8
    end

    # Draw order details.
    @cycle.shop_orders.each_with_index do |so, i|

      # Skip if order does not use trays.
      next unless so.container_type == "trays"

      # Draw bake trays.
      so.containers.each do |container|
        self.txtb container.tray_loading,
                  left + (container.bakestand_column - 1) * 1.5,
                  top - (row_count - container.bakestand_row) * 0.3,
                  1.5,
                  0.3,
                  size: 8,
                  style: :bold,
                  font: "SF Mono",
                  color: FOREGROUND_COLORS[i],
                  fill_color: BACKGROUND_COLORS[i]
      end

    end

    # Draw bakestand diagram.
    column_count.times do |i|
      self.txtb "DO NOT USE",
                left + i * 1.5,
                top,
                1.5,
                0.3,
                fill_color: "cccccc",
                size: 8,
                color: "555555"
      self.vline left + i * 1.5,
                 top,
                 row_count * 0.3
    end
    row_count.times do |i|
      self.hline left,
                 top - i * 0.3,
                 column_count * 1.5
    end
    self.vline left + column_count * 1.5,
               top,
               row_count * 0.3
    self.hline left,
               top - row_count * 0.3,
               column_count * 1.5
    self.txtb "VIEW FROM LOADING SIDE OF BAKESTAND",
              left,
              top - row_count * 0.3,
              1.5 * column_count,
              0.3,
              size: 8,
              v_align: :top,
              v_pad: 0.1,
              color: "555555"

    # Set need new flag for next operation.
    @need_new_page = true

  end

  def print_rod_cart_id_sheet

    # If need new page, create new page and clear flag.
    if @need_new_page
      self.start_new_page
      @need_new_page = false
    end

    # Draw header.
    self.logo 0.25,
              10.75,
              8,
              0.5,
              h_align: :left,
              variant: :mark
    self.txtb "Pre-Bake ID Sheet – Cart ##{@cycle.rod_cart_number}",
              0.85,
              10.75,
              6.75,
              0.5,
              h_align: :left,
              style: :bold,
              transform: :uppercase,
              size: 20

    # Draw order table.
    self.print_order_table(10, "rods")

    # Determine rod cart options.
    top = 3.25
    left = 0.25
    column_count = 16
    row_count = 9

    # Draw order details.
    @cycle.shop_orders.each_with_index do |so, i|

      # Skip if order does not use rods.
      next unless so.container_type == "rods"

      # Draw rods.
      so.containers.each do |container|
        self.txtb container.rod_loading,
                  left + (container.rod_cart_position - 1) * 0.5 + 0.05,
                  top - (row_count - container.rod_cart_shelf) * 0.3 + - 0.05,
                  0.4,
                  0.2,
                  size: 7,
                  style: :bold,
                  font: "SF Mono",
                  color: FOREGROUND_COLORS[i],
                  fill_color: BACKGROUND_COLORS[i]
      end

    end

    # Draw rod cart diagram.
    row_count.times do |i|
      self.hline left,
                 top - i * 0.3,
                 column_count * 0.5
    end
    self.vline left,
               top,
               row_count * 0.3
    self.vline left + column_count * 0.5,
               top,
               row_count * 0.3
    self.hline left,
               top - row_count * 0.3,
               column_count * 0.5
    self.txtb "« BACK OF ROD CART (SIDE W/ STOPS)",
              left,
              top - row_count * 0.3,
              0.5 * column_count,
              0.3,
              size: 8,
              v_align: :top,
              v_pad: 0.1,
              color: "555555",
              h_align: :left

    # Set need new flag for next operation.
    @need_new_page = true

  end

  def print_oven_id_sheet

    # If need new page, create new page and clear flag.
    if @need_new_page
      self.start_new_page
      @need_new_page = false
    end

    # Draw header.
    self.logo 0.25,
              10.75,
              8,
              0.5,
              h_align: :left,
              variant: :mark
    self.txtb "Bake Sheet – #{@cycle.oven_type == "jpw_iao" ? "JPW" : "Grieve"} Oven",
              0.85,
              10.75,
              6.75,
              0.5,
              h_align: :left,
              style: :bold,
              transform: :uppercase,
              size: 20

    # Print bake cycle header.
    self.print_bake_cycle_header(10)

    # Draw order table.
    self.print_order_table(8, nil)

    # Determine rod cart options.
    left = 0.25
    column_count = 16
    container_height = 0.3
    rod_width = 0.5
    tray_width = 1.6
    row_count = case @cycle.oven_type
                when "jpw_iao" then 8
                when "grieve_iao" then 6
                end
    top = 0.25 + ((row_count + 1) * container_height)

    # Draw order details.
    @cycle.shop_orders.each_with_index do |so, i|

      # Draw trays.
      if so.container_type == "trays"
        so.containers.each do |container|
          tray_label = case container.oven_shelf_tray_position
                       when "back_left" then "Back Left:"
                       when "back_center" then "Back Center:"
                       when "back_right" then "Back Right:"
                       when "front_left" then "Front Left:"
                       when "front_right" then "Front Right:"
                       when "front_center" then "Front:"
                       end
          position = 1
          if @cycle.oven_type == "grieve_iao"
            position = case container.oven_shelf_tray_position
                      when "back_left" then 1
                      when "back_right" then 2
                      when "front_center" then 3
                      end
          else
            position = case container.oven_shelf_tray_position
                      when "back_left" then 1
                      when "back_center" then 2
                      when "back_right" then 3
                      when "front_left" then 4
                      when "front_right" then 5
                      end
          end
          self.txtb "#{tray_label}\n#{container.tray_loading}",
                    left + (position - 1) * tray_width + 0.05,
                    top - (row_count - container.oven_shelf) * container_height + - 0.05,
                    tray_width - 0.1,
                    container_height - 0.1,
                    size: 7,
                    style: :bold,
                    font: "SF Mono",
                    color: FOREGROUND_COLORS[i],
                    fill_color: BACKGROUND_COLORS[i]
        end
      end

      # Draw rods.
      if so.container_type == "rods"
        so.containers.each do |container|
          self.txtb container.rod_loading,
                    left + (container.oven_shelf_rod_position - 1) * rod_width + 0.05,
                    top - (row_count - container.oven_shelf) * container_height + - 0.05,
                    rod_width - 0.1,
                    container_height - 0.1,
                    size: 7,
                    style: :bold,
                    font: "SF Mono",
                    color: FOREGROUND_COLORS[i],
                    fill_color: BACKGROUND_COLORS[i]
        end
      end

    end

    # Draw rod cart diagram.
    row_count.times do |i|
      self.hline left,
                 top - i * container_height,
                 column_count * rod_width
    end
    self.vline left,
               top,
               row_count * container_height
    self.vline left + column_count * rod_width,
               top,
               row_count * container_height
    self.hline left,
               top - row_count * container_height,
               column_count * rod_width
    self.txtb "#{@cycle.oven_type == "jpw_iao" ? "JPW" : "Grieve"} Oven",
              left,
              top - row_count * container_height,
              rod_width * column_count,
              container_height,
              size: 8,
              v_align: :top,
              v_pad: 0.1,
              color: "555555",
              h_align: :center

    # Set need new flag for next operation.
    @need_new_page = true

  end

  def print_bake_cycle_header(y)

    # Draw header for bake cycle properties.
    x = 1.25
    width = 6
    if ["grieve_iao", "jpw_iao"].include?(@cycle.oven_type)
      width += 1
      x -= 0.5
      self.txtb "Profile", x + 5, y, 1, 0.25, style: :bold, fill_color: "cccccc", line_color: "000000"
      self.txtb @cycle.bake_profile, x + 5, y - 0.25, 1, 0.5, style: :bold, font: "SF Mono", line_color: "000000", size: 16
      self.txtb "Cycle", x + 6, y, 1, 0.25, style: :bold, fill_color: "cccccc", line_color: "000000"
      self.txtb @cycle.id, x + 6, y - 0.25, 1, 0.5, style: :bold, font: "SF Mono", line_color: "000000", size: 16, color: "ffffff", fill_color: "333333"
    else
      self.txtb "Cycle", x + 5, y, 1, 0.25, style: :bold, fill_color: "cccccc", line_color: "000000"
      self.txtb @cycle.id, x + 5, y - 0.25, 1, 0.5, style: :bold, font: "SF Mono", line_color: "000000", size: 16, color: "ffffff", fill_color: "333333"
    end
    self.txtb "Oven", x, y, 1, 0.25, style: :bold, fill_color: "cccccc", line_color: "000000"
    self.txtb "Set (º F)", x + 1, y, 1, 0.25, style: :bold, fill_color: "cccccc", line_color: "000000"
    self.txtb "Min (º F)", x + 2, y, 1, 0.25, style: :bold, fill_color: "cccccc", line_color: "000000"
    self.txtb "Max (º F)", x + 3, y, 1, 0.25, style: :bold, fill_color: "cccccc", line_color: "000000"
    self.txtb "Soak (Hrs)", x + 4, y, 1, 0.25, style: :bold, fill_color: "cccccc", line_color: "000000"

    # Draw bake cycle properties.
    y -= 0.25
    case @cycle.oven_type
    when "grieve_iao"
      self.txtb "Grieve", x, y, 1, 0.5, style: :bold, font: "SF Mono", line_color: "000000", size: 16
    when "jpw_iao"
      self.txtb "JPW", x, y, 1, 0.5, style: :bold, font: "SF Mono", line_color: "000000", size: 16
    else
      self.rect x, y, 1, 0.5, fill_color: "ffffcc", line_color: "000000"
    end
    self.txtb @cycle.setpoint, x + 1, y, 1, 0.5, style: :bold, font: "SF Mono", line_color: "000000", size: 16
    self.txtb @cycle.minimum, x + 2, y, 1, 0.5, style: :bold, font: "SF Mono", line_color: "000000", size: 16
    self.txtb @cycle.maximum, x + 3, y, 1, 0.5, style: :bold, font: "SF Mono", line_color: "000000", size: 16
    self.txtb (@cycle.soak_length / 60.0).to_f.round(1), x + 4, y, 1, 0.5, style: :bold, font: "SF Mono", line_color: "000000", size: 16

    # Draw line for date/time out of plating.
    y -= 0.5
    self.txtb "Date/Time Out of Plating:", x, y, self.calc_width("Date/Time Out of Plating:", style: :bold), 0.5, style: :bold, h_align: :right, v_align: :bottom
    self.rect x + self.calc_width("Date/Time Out of Plating:", style: :bold) + 0.1, y - 0.2, width - self.calc_width("Date/Time Out of Plating:", style: :bold) - 0.1, 0.3, fill_color: "ffffcc", line_color: nil
    self.hline x + self.calc_width("Date/Time Out of Plating:", style: :bold) + 0.1, y - 0.5, width - self.calc_width("Date/Time Out of Plating:", style: :bold) - 0.1
    y -= 0.5
    self.txtb "Put in Oven By:", x, y, self.calc_width("Date/Time Out of Plating:", style: :bold), 0.5, style: :bold, h_align: :right, v_align: :bottom
    self.rect x + self.calc_width("Date/Time Out of Plating:", style: :bold) + 0.1, y - 0.2, width - self.calc_width("Date/Time Out of Plating:", style: :bold) - 0.1, 0.3, fill_color: "ffffcc", line_color: nil
    self.hline x + self.calc_width("Date/Time Out of Plating:", style: :bold) + 0.1, y - 0.5, width - self.calc_width("Date/Time Out of Plating:", style: :bold) - 0.1

  end

  def print_order_table(y, container_type)

    # Draw header for list of orders.
    self.txtb "S.O. #",
              0.25,
              y,
              1,
              0.5,
              style: :bold,
              fill_color: "cccccc",
              line_color: "000000"
    self.txtb "Part Specification",
              1.25,
              y,
              3.5,
              0.5,
              style: :bold,
              fill_color: "cccccc",
              line_color: "000000",
              h_align: :left,
              h_pad: 0.1
    self.txtb "Set\n(º F)",
              4.75,
              y,
              0.7,
              0.5,
              style: :bold,
              fill_color: "cccccc",
              line_color: "000000"
    self.txtb "Min\n(º F)",
              5.45,
              y,
              0.7,
              0.5,
              style: :bold,
              fill_color: "cccccc",
              line_color: "000000"
    self.txtb "Max\n(º F)",
              6.15,
              y,
              0.7,
              0.5,
              style: :bold,
              fill_color: "cccccc",
              line_color: "000000"
    self.txtb "Soak\n(Hours)",
              6.85,
              y,
              0.7,
              0.5,
              style: :bold,
              fill_color: "cccccc",
              line_color: "000000"
    self.txtb "Within\n(Hours)",
              7.55,
              y,
              0.7,
              0.5,
              style: :bold,
              fill_color: "cccccc",
              line_color: "000000"
    y -= 0.2

    # Draw order details.
    @cycle.shop_orders.each_with_index do |so, i|

      # Skip if order does not use trays.
      unless container_type.nil?
        next unless so.container_type == container_type
      end

      # Draw order in list of orders.
      y -= 0.3
      self.rect 0.25,
                y,
                8,
                0.3,
                fill_color: BACKGROUND_COLORS[i],
                line_color: nil
      self.txtb so.as400_shop_order.number,
                0.25,
                y,
                1,
                0.3,
                line_color: "000000",
                font: "SF Mono",
                color: FOREGROUND_COLORS[i]
      self.txtb so.as400_shop_order.part_spec.join(" / "),
                1.25,
                y,
                3.5,
                0.3,
                line_color: "000000",
                font: "SF Mono",
                h_align: :left,
                h_pad: 0.1,
                color: FOREGROUND_COLORS[i]
      self.txtb so.setpoint,
                4.75,
                y,
                0.7,
                0.3,
                line_color: "000000",
                font: "SF Mono",
                color: FOREGROUND_COLORS[i]
      self.txtb so.minimum,
                5.45,
                y,
                0.7,
                0.3,
                line_color: "000000",
                font: "SF Mono",
                color: FOREGROUND_COLORS[i]
      self.txtb so.maximum,
                6.15,
                y,
                0.7,
                0.3,
                line_color: "000000",
                font: "SF Mono",
                color: FOREGROUND_COLORS[i]
      self.txtb (so.soak_length / 60.0).to_f.round(1),
                6.85,
                y,
                0.7,
                0.3,
                line_color: "000000",
                font: "SF Mono",
                color: FOREGROUND_COLORS[i]
      self.txtb (so.bake_within / 60.0).to_f.round(1),
                7.55,
                y,
                0.7,
                0.3,
                line_color: "000000",
                font: "SF Mono",
                color: FOREGROUND_COLORS[i]

    end

  end

end