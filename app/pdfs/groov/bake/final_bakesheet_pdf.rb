require "open-uri"

class Groov::Bake::FinalBakesheetPdf < ::VarlandPdf

  BACKGROUND_COLORS = ['7be042', 'ff657f', '9cb5f2', 'ffc72d', 'b677ff', '73fdff', 'fca7ff', 'bdffd1', 'ffd6bd', 'dcecff']
  FOREGROUND_COLORS = ['000000', '000000', '000000', '000000', '000000', '000000', '000000', '000000', '000000', '000000']

  def initialize(cycle)
    super()
    @cycle = cycle
    self.print_data
  end

  def print_data
    @need_new_page = false
    self.print_bakestand_id_sheet if @cycle.has_bakestand?
    self.print_rod_cart_id_sheet if @cycle.has_rod_cart?
    @cycle.shop_orders.each do |so|
      self.print_order_sheet so
    end
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
    self.txtb "Final Bakesheet – Bakestand ##{@cycle.bakestand_number}",
              0.85,
              10.75,
              6.75,
              0.5,
              h_align: :left,
              style: :bold,
              transform: :uppercase,
              size: 20

    # Draw header for list of orders.
    self.txtb "S.O. #",
              0.25,
              10,
              1,
              0.5,
              style: :bold,
              fill_color: "cccccc",
              line_color: "000000"
    self.txtb "Part Specification",
              1.25,
              10,
              4,
              0.5,
              style: :bold,
              fill_color: "cccccc",
              line_color: "000000",
              h_align: :left,
              h_pad: 0.1
    self.txtb "QC Approval to Dump",
              5.25,
              10,
              3,
              0.5,
              style: :bold,
              fill_color: "cccccc",
              line_color: "000000"
    y = 9.8

    # Determine bakestand options.
    top = 6.25
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

      # Draw order in list of orders.
      y -= 0.3
      self.rect 0.25,
                y,
                5,
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
                4,
                0.3,
                line_color: "000000",
                font: "SF Mono",
                h_align: :left,
                h_pad: 0.1,
                color: FOREGROUND_COLORS[i]
      self.rect 5.25, y, 3, 0.3

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
    self.txtb "Final Bakesheet – Rod Cart ##{@cycle.rod_cart_number}",
              0.85,
              10.75,
              6.75,
              0.5,
              h_align: :left,
              style: :bold,
              transform: :uppercase,
              size: 20

    # Draw header for list of orders.
    self.txtb "S.O. #",
              0.25,
              10,
              1,
              0.5,
              style: :bold,
              fill_color: "cccccc",
              line_color: "000000"
    self.txtb "Part Specification",
              1.25,
              10,
              4,
              0.5,
              style: :bold,
              fill_color: "cccccc",
              line_color: "000000",
              h_align: :left,
              h_pad: 0.1
    self.txtb "QC Approval to Dump",
              5.25,
              10,
              3,
              0.5,
              style: :bold,
              fill_color: "cccccc",
              line_color: "000000"
    y = 9.8

    # Determine rod cart options.
    top = 6.25
    left = 0.25
    column_count = 16
    row_count = 9

    # Draw order details.
    @cycle.shop_orders.each_with_index do |so, i|

      # Skip if order does not use rods.
      next unless so.container_type == "rods"

      # Draw order in list of orders.
      y -= 0.3
      self.rect 0.25,
                y,
                5,
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
                4,
                0.3,
                line_color: "000000",
                font: "SF Mono",
                h_align: :left,
                h_pad: 0.1,
                color: FOREGROUND_COLORS[i]
      self.rect 5.25, y, 3, 0.3

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

  def print_order_sheet(so)

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
    self.txtb "S.O. ##{so.as400_shop_order.number}",
              0.85,
              10.75,
              6.75,
              0.5,
              h_align: :left,
              style: :bold,
              transform: :uppercase,
              size: 20
    self.txtb so.as400_shop_order.part_spec.join(" / "),
              0.25,
              10.75,
              8,
              0.5,
              h_align: :right,
              size: 12,
              font: "SF Mono"

    # Draw cycle details.
    y = 10
    oven_box_height = case so.cycle.oven_type
                      when "grieve_iao", "jpw_iao" then 4
                      else 3
                      end
    header_box_options = { line_color: "000000",
                           fill_color: "cccccc",
                           h_align: :right,
                           h_pad: 0.1,
                           size: 9 }
    data_box_options = { line_color: "000000",
                         h_align: :left,
                         h_pad: 0.1,
                         font: "SF Mono",
                         style: :bold,
                         size: 9 }
    self.txtb "Oven",
              0.25,
              y,
              1,
              0.3,
              fill_color: "cccccc",
              line_color: "000000",
              size: 9
    self.txtb "Set:",
              1.25,
              y,
              1,
              0.3,
              header_box_options
    self.txtb "#{so.setpoint}º F",
              2.25,
              y,
              1,
              0.3,
              data_box_options
    self.txtb "Loadings Entered By:",
              3.25,
              y,
              2,
              0.3,
              header_box_options
    self.txtb "#{so.cycle.user.employee_number} #{so.cycle.user.name}",
              5.25,
              y,
              3,
              0.3,
              data_box_options
    y -= 0.3
    self.txtb "#{so.cycle.oven}#{so.cycle.side unless so.cycle.side.blank?}",
              0.25,
              y,
              1,
              0.3 * oven_box_height,
              line_color: "000000",
              h_align: :center,
              h_pad: 0.1,
              font: "SF Mono",
              style: :bold,
              size: 14
    self.txtb "Min:",
              1.25,
              y,
              1,
              0.3,
              header_box_options
    self.txtb "#{so.minimum}º F",
              2.25,
              y,
              1,
              0.3,
              data_box_options
    self.txtb "Date/Time Loadings Entered:",
              3.25,
              y,
              2,
              0.3,
              header_box_options
    self.txtb so.cycle.cycle_started_at.strftime("%m/%d/%Y %l:%M%P"),
              5.25,
              y,
              3,
              0.3,
              data_box_options
    y -= 0.3
    self.txtb "Max:",
              1.25,
              y,
              1,
              0.3,
              header_box_options
    self.txtb "#{so.maximum}º F",
              2.25,
              y,
              1,
              0.3,
              data_box_options
    self.txtb "Date/Time Soak Started:",
              3.25,
              y,
              2,
              0.3,
              header_box_options
    self.txtb so.cycle.soak_started_at.strftime("%m/%d/%Y %l:%M%P"),
              5.25,
              y,
              3,
              0.3,
              data_box_options
    y -= 0.3
    self.txtb "Hours:",
              1.25,
              y,
              1,
              0.3,
              header_box_options
    self.txtb (so.soak_length / 60.0).to_f.round(1),
              2.25,
              y,
              1,
              0.3,
              data_box_options
    self.txtb "Date/Time Soak Ended:",
              3.25,
              y,
              2,
              0.3,
              header_box_options
    self.txtb so.cycle.soak_ended_at.strftime("%m/%d/%Y %l:%M%P"),
              5.25,
              y,
              3,
              0.3,
              data_box_options
    if ["grieve_iao", "jpw_iao"].include?(so.cycle.oven_type)
      y -= 0.3
      self.txtb "Profile:",
                1.25,
                y,
                1,
                0.3,
                header_box_options
      self.txtb so.bake_profile,
                2.25,
                y,
                1,
                0.3,
                data_box_options
      self.txtb "Date/Time Cycle Ended:",
                3.25,
                y,
                2,
                0.3,
                header_box_options
      self.txtb so.cycle.cycle_ended_at.strftime("%m/%d/%Y %l:%M%P"),
                5.25,
                y,
                3,
                0.3,
                data_box_options
    end

    # Draw loads list.
    y -= 0.55
    header_box_options = { line_color: "000000",
                           fill_color: "cccccc",
                           h_align: :center,
                           h_pad: 0.1,
                           size: 9 }
    self.txtb "Load #",
              0.25,
              y,
              0.5,
              0.5,
              header_box_options
    self.txtb "Date/Time Out of Plating",
              0.75,
              y,
              2,
              0.5,
              header_box_options
    self.txtb "Date/Time Loaded in Oven",
              2.75,
              y,
              2,
              0.5,
              header_box_options
    self.txtb "Bake Within\n(Hours)",
              4.75,
              y,
              1.25,
              0.5,
              header_box_options
    self.txtb "Time to Load\n(Hours)",
              6,
              y,
              1.25,
              0.5,
              header_box_options
    self.txtb "Met\nSpec?",
              7.25,
              y,
              1,
              0.5,
              header_box_options
    y -= 0.2
    so.loads.each_with_index do |load, i|
      y -= 0.3
      self.txtb load.number_and_indicator,
                0.25,
                y,
                0.5,
                0.3,
                line_color: "000000",
                font: "SF Mono",
                h_align: :center,
                color: FOREGROUND_COLORS[i],
                fill_color: BACKGROUND_COLORS[i]
      if load.plated_load.blank?
        self.rect 0.75, y, 2, 0.3
        self.rect 4.75, y, 1.25, 0.3
        self.rect 6, y, 1.25, 0.3
        self.rect 7.25, y, 1, 0.3
      else
        self.txtb load.plated_load.out_of_plating_at.strftime("%m/%d/%Y %l:%M%P"),
                  0.75,
                  y,
                  2,
                  0.3,
                  line_color: "000000",
                  font: "SF Mono",
                  h_align: :left,
                  h_pad: 0.1
        self.txtb (load.plated_load.bake_within / 60.0).to_f.round(1),
                  4.75,
                  y,
                  1.25,
                  0.3,
                  line_color: "000000",
                  font: "SF Mono",
                  h_align: :center
        self.txtb load.plated_load.time_to_load.to_f.round(2),
                  6,
                  y,
                  1.25,
                  0.3,
                  line_color: "000000",
                  font: "SF Mono",
                  h_align: :center
        self.txtb load.plated_load.met_spec? ? "Yes" : "No",
                  7.25,
                  y,
                  1,
                  0.3,
                  line_color: "000000",
                  font: "SF Mono",
                  h_align: :center,
                  color: (load.plated_load.met_spec? ? "000000" : "ff0000")
      end
      self.txtb load.in_oven_at.strftime("%m/%d/%Y %l:%M%P"),
                2.75,
                y,
                2,
                0.3,
                line_color: "000000",
                font: "SF Mono",
                h_align: :left,
                h_pad: 0.1
    end

    # If not enough room for graph, start new page.
    y -= 0.55
    if y < 6
      self.start_new_page
      self.logo 0.25,
                10.75,
                8,
                0.5,
                h_align: :left,
                variant: :mark
      self.txtb "S.O. ##{so.as400_shop_order.number}",
                0.85,
                10.75,
                6.75,
                0.5,
                h_align: :left,
                style: :bold,
                transform: :uppercase,
                size: 20
      self.txtb so.as400_shop_order.part_spec.join(" / "),
                0.25,
                10.75,
                8,
                0.5,
                h_align: :right,
                size: 12,
                font: "SF Mono"
      y = 10
    end

    # Draw placeholder for graph.
    self.image(open(@cycle.temperature_chart_url), at: [0.25.in, y.in], width: 8.in, height: @cycle.temperature_chart_height.in)
    unless @cycle.state_chart_height == 0
      self.image(open(@cycle.state_chart_url), at: [0.25.in, (y - @cycle.temperature_chart_height).in], width: 8.in, height: @cycle.state_chart_height.in)
    end
    self.rect 0.25, y, 8, 4

    # Draw mini bakestand.
    y -= 4.25
    self.draw_mini_bakestand(so, y) if so.container_type == "trays"
    self.draw_mini_oven_for_trays(so, y) if so.container_type == "trays" && ["jpw_iao", "grieve_iao"].include?(@cycle.oven_type)
    self.draw_mini_rod_cart(so, y) if so.container_type == "rods"
    self.draw_mini_oven_for_rods(so, y) if so.container_type == "rods"

    # Set need new flag for next operation.
    @need_new_page = true

  end

  def draw_mini_rod_cart(so, y)

    # Determine rod cart options.
    top = y
    left = 0.25
    column_count = 16
    row_count = 9
    rod_width = 0.15
    rod_height = 0.15

    # Draw rods.
    so.loads.each_with_index do |load, i|
      load.containers.each do |container|
        self.rect left + (container.rod_cart_position - 1) * rod_width + 0.03,
                  top - (row_count - container.rod_cart_shelf) * rod_height + - 0.03,
                  rod_width - 0.06,
                  rod_height - 0.06,
                  fill_color: BACKGROUND_COLORS[i]
      end
    end

    # Draw rod cart diagram.
    row_count.times do |i|
      self.hline left,
                 top - i * rod_height,
                 column_count * rod_width
    end
    self.vline left,
               top,
               row_count * rod_height
    self.vline left + column_count * rod_width,
               top,
               row_count * rod_height
    self.hline left,
               top - row_count * rod_height,
               column_count * rod_width
    self.txtb "Rod Cart ##{@cycle.rod_cart_number}",
              left,
              top - row_count * rod_height,
              rod_width * column_count,
              0.3,
              size: 8,
              v_align: :top,
              v_pad: 0.05,
              color: "555555",
              h_align: :center

  end

  def draw_mini_bakestand(so, y)

    # Determine bakestand options.
    top = y
    left = 0.25
    column_count = 4
    row_count = 11
    tray_width = 0.5
    tray_height = 0.12
    if @cycle.oven_type == "small_oven"
      column_count = 2
      row_count = 8
    end

    # Draw trays.
    so.loads.each_with_index do |load, i|
      load.containers.each do |container|
        self.rect left + (container.bakestand_column - 1) * tray_width,
                  top - (row_count - container.bakestand_row) * tray_height,
                  tray_width,
                  tray_height,
                  fill_color: BACKGROUND_COLORS[i]
      end
    end

    # Draw bakestand diagram.
    column_count.times do |i|
      self.rect left + i * tray_width,
                top,
                tray_width,
                tray_height,
                fill_color: "cccccc"
      self.vline left + i * tray_width,
                 top,
                 row_count * tray_height
    end
    row_count.times do |i|
      self.hline left,
                 top - i * tray_height,
                 column_count * tray_width
    end
    self.vline left + column_count * tray_width,
               top,
               row_count * tray_height
    self.hline left,
               top - row_count * tray_height,
               column_count * tray_width
    self.txtb "Bakestand ##{@cycle.bakestand_number}",
              left,
              top - row_count * tray_height,
              tray_width * column_count,
              0.3,
              size: 8,
              v_align: :top,
              v_pad: 0.05,
              color: "555555",
              h_align: :center

  end

  def draw_mini_oven_for_rods(so, y)

    # Determine oven options.
    top = y
    column_count = 16
    row_count = case @cycle.oven_type
                when "jpw_iao" then 8
                when "grieve_iao" then 6
                else nil
                end
    return if row_count.nil?
    rod_width = 0.15
    rod_height = 0.15
    left = 8.25 - column_count * rod_width

    # Draw rods.
    so.loads.each_with_index do |load, i|
      load.containers.each do |container|
        self.rect left + (container.oven_shelf_rod_position - 1) * rod_width + 0.03,
                  top - (row_count - container.oven_shelf) * rod_height + - 0.03,
                  rod_width - 0.06,
                  rod_height - 0.06,
                  fill_color: BACKGROUND_COLORS[i]
      end
    end

    # Draw oven diagram.
    row_count.times do |i|
      self.hline left,
                 top - i * rod_height,
                 column_count * rod_width
    end
    self.vline left,
               top,
               row_count * rod_height
    self.vline left + column_count * rod_width,
               top,
               row_count * rod_height
    self.hline left,
               top - row_count * rod_height,
               column_count * rod_width
    self.txtb "#{@cycle.oven} Oven",
              left,
              top - row_count * rod_height,
              rod_width * column_count,
              0.3,
              size: 8,
              v_align: :top,
              v_pad: 0.05,
              color: "555555",
              h_align: :center

  end

  def draw_mini_oven_for_trays(so, y)

    # Determine oven options.
    top = y
    column_count = case @cycle.oven_type
                   when "jpw_iao" then 3
                   when "grieve_iao" then 2
                   else nil
                   end
    row_count = case @cycle.oven_type
                when "jpw_iao" then 8
                when "grieve_iao" then 6
                else nil
                end
    return if row_count.nil? || column_count.nil?
    tray_width = 0.8
    tray_height = 0.12
    left = 8.25 - column_count * tray_width

    # Draw trays.
    so.loads.each_with_index do |load, i|
      load.containers.each do |container|
        position = case container.oven_shelf_tray_position
                   when "back_left" then 1
                   when "back_center" then 2
                   when "back_right" then (@cycle.oven_type == "jpw_iao" ? 3 : 2)
                   when "front_left" then 1.5
                   when "front_center" then 1.5
                   when "front_right" then 2.5
                   else nil
                   end
        top_offset = case container.oven_shelf_tray_position
                     when "back_left" then 0
                     when "back_center" then 0
                     when "back_right" then 0
                     when "front_left" then tray_height
                     when "front_center" then tray_height
                     when "front_right" then tray_height
                     else 0
                     end
        self.rect left + (position - 1) * tray_width + 0.03,
                  top - (row_count - container.oven_shelf) * tray_height * 2 - 0.03 - top_offset,
                  tray_width - 0.06,
                  tray_height - 0.06,
                  fill_color: BACKGROUND_COLORS[i]
      end
    end

    # Draw oven diagram.
    row_count.times do |i|
      self.hline left,
                 top - i * tray_height * 2,
                 column_count * tray_width
    end
    self.vline left,
               top,
               row_count * tray_height * 2
    self.vline left + column_count * tray_width,
               top,
               row_count * tray_height * 2
    self.hline left,
               top - row_count * tray_height * 2,
               column_count * tray_width
    self.txtb "#{@cycle.oven} Oven",
              left,
              top - row_count * tray_height * 2,
              tray_width * column_count,
              0.3,
              size: 8,
              v_align: :top,
              v_pad: 0.05,
              color: "555555",
              h_align: :center

  end

end