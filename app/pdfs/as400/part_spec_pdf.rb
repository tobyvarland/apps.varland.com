class AS400::PartSpecPdf < ::VarlandPdf

  PAGE_ORIENTATION = :portrait
  BADGE_SPACING = 0.05
  VALID_BADGE_BACKGROUND_COLOR = "149911"
  VALID_BADGE_TEXT_COLOR = "ffffff"
  INVALID_BADGE_BACKGROUND_COLOR = "f55d3e"
  INVALID_BADGE_TEXT_COLOR = "ffffff"
  DEVELOPMENTAL_BADGE_COLOR = "3c91e6"
  DEVELOPMENTAL_BADGE_TEXT_COLOR = "ffffff"
  DEFAULT_BADGE_COLOR = "dddddd"
  DEFAULT_BADGE_TEXT_COLOR = "000000"
  PART_NAME_LINE_HEIGHT = 0.175
  DEFAULT_LINE_HEIGHT = 0.2

  def initialize(customer, process, part, sub, format)

    # Initialize report.
    super()

    # Store params.
    @customer = customer
    @process = process
    @part = part
    @sub = sub
    @format = format

    # Load data.
    self.load_data

    # Print data.
    self.print_data

    # Print header and title on all pages.
    self.repeat(:all) do

      # Draw header & logo.
      self.logo(0.25, 10.75, 8, 0.4, variant: :mark, mono: false, h_align: :left)
      keys = [@customer, @process, @part]
      keys << @sub unless @sub.blank?
      self.txtb("<strong>#{keys.join("</strong> / <strong>")}</strong> <font size='9'>#{@data[:customer_name]}</font>", 0.7, 10.75, 6, 0.25, h_align: :left, style: :normal, size: 14, v_align: :top)
      badge_x = 0.7
      badge_x += self.procedure_badge(x: badge_x, y: 10.5) + self.class::BADGE_SPACING
      badge_x += self.price_badge(x: badge_x, y: 10.5) + self.class::BADGE_SPACING
      #badge_x += self.automatic_pricing_badge(x: badge_x, y: 10.5) + self.class::BADGE_SPACING
      badge_x += self.inactive_badge(x: badge_x, y: 10.5) + self.class::BADGE_SPACING
      self.developmental_badge(x: badge_x, y: 10.5)

      # Draw update information.
      self.txtb "Last Update".upcase, 6.55, 10.75, 1.7, 0.2, fill_color: "333333", color: "ffffff", size: 6, style: :bold, line_color: "000000", line_width: 0.005
      update_time = Time.parse(@data[:update_info][:timestamp])
      self.txtb "#{@data[:update_info][:operator]}:#{@data[:update_info][:authorizer]}", 6.55, 10.55, 0.5, 0.2, size: 6, line_color: "000000", h_pad: 0.05, line_width: 0.005, font: "SF Mono"
      self.txtb update_time.strftime("%m/%d/%y"), 7.05, 10.55, 0.6, 0.2, size: 6, line_color: "000000", h_pad: 0.05, line_width: 0.005, font: "SF Mono"
      self.txtb update_time.strftime("%H:%M:%S"), 7.65, 10.55, 0.6, 0.2, size: 6, line_color: "000000", h_pad: 0.05, line_width: 0.005, font: "SF Mono"

    end

    # Number pages.
    if self.page_count > 1
      string = "<font name='#{self.class::DEFAULT_FONT_FAMILY}'>Page <page> of <total></font>"
      options = { at: [0.25.in, 0.5.in],
                  width: 8.in,
                  height: 0.25.in,
                  align: :right,
                  size: 6,
                  start_count_at: 1,
                  valign: :bottom,
                  inline_format: true }
      self.number_pages(string, options)
    end

  end

  def load_data
    uri = URI.parse("http://json400.varland.com/print_part_spec?customer=#{@customer}&process=#{@process}&part=#{@part}&sub=#{@sub.to_s}")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    @data = nil unless response.code.to_s == "200"
    @data = JSON.parse(response.body, symbolize_names: true)
  end

  def print_data

    # Print part name, description, process spec, and application.
    y = 10.25
    self.txtb "Part Name:".upcase, 0.25, y, 2.5, self.class::PART_NAME_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    self.txtb "Process Specification:".upcase, 3, y, 2.5, self.class::PART_NAME_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    self.txtb "Industry:".upcase, 5.75, y, 1.25, self.class::PART_NAME_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    self.txtb "Sub-Industry:".upcase, 7, y, 1.25, self.class::PART_NAME_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb @data[:industry], 5.75, y, 1.25, self.class::PART_NAME_LINE_HEIGHT, size: 7, h_align: :left, font: "SF Mono", style: :bold
    self.txtb @data[:sub_industry], 7, y, 1.25, self.class::PART_NAME_LINE_HEIGHT, size: 7, h_align: :left, font: "SF Mono", style: :bold
    part_name_y = y
    process_spec_y = y
    application_y = @data[:application].length == 0 ? y : y - 2 * self.class::PART_NAME_LINE_HEIGHT
    @data[:part_name].each do |line|
      self.txtb line, 0.25, part_name_y, 2.5, self.class::PART_NAME_LINE_HEIGHT, size: 7, h_align: :left, font: "SF Mono", style: :bold
      part_name_y -= self.class::PART_NAME_LINE_HEIGHT
    end
    @data[:process_spec].each do |line|
      self.txtb line, 3, process_spec_y, 2.5, self.class::PART_NAME_LINE_HEIGHT, size: 7, h_align: :left, font: "SF Mono", style: :bold
      process_spec_y -= self.class::PART_NAME_LINE_HEIGHT
    end
    part_description_y = part_name_y - self.class::PART_NAME_LINE_HEIGHT
    self.txtb "Part Description:".upcase, 0.25, part_description_y, 2.5, self.class::PART_NAME_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    part_description_y -= self.class::PART_NAME_LINE_HEIGHT
    @data[:part_description].each do |line|
      self.txtb line, 0.25, part_description_y, 2.5, self.class::PART_NAME_LINE_HEIGHT, size: 7, h_align: :left, font: "SF Mono", style: :bold
      part_description_y -= self.class::PART_NAME_LINE_HEIGHT
    end
    unless @data[:application].length == 0
      self.txtb "Application:".upcase, 5.75, application_y, 2.5, self.class::PART_NAME_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
      application_y -= self.class::PART_NAME_LINE_HEIGHT
      @data[:application].each do |line|
        self.txtb line, 5.75, application_y, 2.5, self.class::PART_NAME_LINE_HEIGHT, size: 7, h_align: :left, font: "SF Mono", style: :bold
        application_y -= self.class::PART_NAME_LINE_HEIGHT
      end
    end

    # Update y position.
    y = [part_description_y, process_spec_y, application_y].min - self.class::DEFAULT_LINE_HEIGHT
    annual_comparison_y = y
    other_properties_y = y

    # Print other part properties.
    self.txtb "<u>PART AREA & WEIGHT</u>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, size: 8, style: :bold, h_align: :left
    self.txtb "<u>PART CALCULATIONS</u>", 2.75, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, size: 8, style: :bold, h_align: :left
    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb "AREA: <strong><font name='SF Mono' size='7'>#{@data[:area][:value]} #{@data[:area][:unit] == 'F' ? 'ft' : 'in'}<sup>2</sup>/#{@data[:area][:per] == 'E' ? 'pc' : 'lb'}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    self.txtb "PIECES PER POUND: <strong><font name='SF Mono' size='7'>#{@data[:pcs_per_lb]} pcs/lb</font></strong>", 2.75, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb "PIECE WEIGHT: <strong><font name='SF Mono' size='7'>#{@data[:piece_weight]} lbs</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    self.txtb "POUNDS PER THOUSAND: <strong><font name='SF Mono' size='7'>#{@data[:lbs_per_thousand]} lbs/m</font></strong>", 2.75, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb "POUNDS PER CUBIC: <strong><font name='SF Mono' size='7'>#{@data[:pounds_per_cubic]} lbs/ft<sup>3</sup></font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    self.txtb "SQUARE FEET PER POUND: <strong><font name='SF Mono' size='7'>#{@data[:square_feet_per_lb]} ft<sup>2</sup>/lb</font></strong>", 2.75, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb "SQUARE FEET PER THOUSAND: <strong><font name='SF Mono' size='7'>#{@data[:square_feet_per_thousand]} ft<sup>2</sup>/m</font></strong>", 2.75, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb "GRAMS PER PIECE: <strong><font name='SF Mono' size='7'>#{@data[:piece_weight_grams]} g/pc</font></strong>", 2.75, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb "SQUARE CM PER PIECE: <strong><font name='SF Mono' size='7'>#{@data[:square_cm_per_piece]} cm<sup>2</sup>/pc</font></strong>", 2.75, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT

    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb "<u>OTHER PART INFORMATION</u>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, size: 8, style: :bold, h_align: :left
    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb "CERTIFY CODE: <strong><font name='SF Mono' size='7'>#{@data[:certify_code].nil? ? " " : @data[:certify_code]}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb "SCHEDULE CODE: <strong><font name='SF Mono' size='7'>#{@data[:schedule_code].nil? ? " " : @data[:schedule_code]}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb "BASE METAL: <strong><font name='SF Mono' size='7'>#{@data[:base_metal].nil? ? " " : @data[:base_metal]}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb "HOW SHIPPED: <strong><font name='SF Mono' size='7'>#{@data[:how_shipped].nil? ? " " : @data[:how_shipped]}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb "PRINT ID: <strong><font name='SF Mono' size='7'>#{@data[:print_id].nil? ? " " : @data[:print_id]}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb "EQUIPMENT USED: <strong><font name='SF Mono' size='7'>#{@data[:equipment_used].length == 0 ? " " : @data[:equipment_used][0]}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    if @data[:equipment_used].length > 1
      self.txtb "<color rgb='ffffff'>EQUIPMENT USED:</color> <strong><font name='SF Mono' size='7'>#{@data[:equipment_used][1]}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
      other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    end

    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb "<u>PRICING INFORMATION</u>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, size: 8, style: :bold, h_align: :left
    self.txtb("<u>QUOTATION INFORMATION</u>", 2.75, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, size: 8, style: :bold, h_align: :left) unless @data[:quote][:number].nil? || @data[:quote][:number].to_i == 0
    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb "PRICE: <strong><font name='SF Mono' size='7'>$#{@data[:price][:price]}/#{@data[:price][:per].downcase} #{@data[:price][:price_date].nil? ? "" : Date.parse(@data[:price][:price_date]).strftime("(%m/%d/%y)")}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    self.txtb("QUOTE #: <strong><font name='SF Mono' size='7'>#{@data[:quote][:number]}</font></strong>", 2.75, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left) unless @data[:quote][:number].nil? || @data[:quote][:number].to_i == 0
    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb "SETUP: <strong><font name='SF Mono' size='7'>$#{@data[:price][:setup]} #{@data[:price][:setup_date].nil? ? "" : Date.parse(@data[:price][:setup_date]).strftime("(%m/%d/%y)")}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    self.txtb("VALID: <strong><font name='SF Mono' size='7'>#{@data[:quote][:valid] ? "YES" : "NO"}</font></strong>", 2.75, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left) unless @data[:quote][:number].nil? || @data[:quote][:number].to_i == 0
    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb "MINIMUM: <strong><font name='SF Mono' size='7'>$#{@data[:price][:minimum]} #{@data[:price][:minimum_date].nil? ? "" : Date.parse(@data[:price][:minimum_date]).strftime("(%m/%d/%y)")}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    self.txtb("EFFECTIVE DATE: <strong><font name='SF Mono' size='7'>#{Date.parse(@data[:quote][:effective_date]).strftime("%m/%d/%y")}</font></strong>", 2.75, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left) unless @data[:quote][:number].nil? || @data[:quote][:number].to_i == 0
    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb "DIFFICULTY FACTOR: <strong><font name='SF Mono' size='7'>#{@data[:price][:difficulty_factor]}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    self.txtb("PRICE: <strong><font name='SF Mono' size='7'>$#{@data[:quote][:price]}/#{@data[:quote][:per].downcase}</font></strong>", 2.75, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left) unless @data[:quote][:number].nil? || @data[:quote][:number].to_i == 0
    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb("SETUP: <strong><font name='SF Mono' size='7'>$#{@data[:quote][:setup]}</font></strong>", 2.75, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left) unless @data[:quote][:number].nil? || @data[:quote][:number].to_i == 0
    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb("MINIMUM: <strong><font name='SF Mono' size='7'>$#{@data[:quote][:minimum]}</font></strong>", 2.75, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left) unless @data[:quote][:number].nil? || @data[:quote][:number].to_i == 0
    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT

    unless @data[:remarks].nil? && @data[:review_date].nil?
      other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
      self.txtb "<u>REMARKS & REVIEW</u>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, size: 8, style: :bold, h_align: :left
      other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
      unless @data[:remarks].nil?
        self.txtb "REMARKS: <strong><font name='SF Mono' size='7'>#{@data[:remarks]}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
        other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
      end
      unless @data[:review_date].nil?
        self.txtb "REVIEW DATE: <strong><font name='SF Mono' size='7'>#{Date.parse(@data[:review_date]).strftime("%m/%d/%y")}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
        other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
      end
    end

    # Print annual comparison & last few orders summary.
    annual_comparison_y = self.draw_photo(annual_comparison_y)
    annual_comparison_y = self.annual_comparison(annual_comparison_y)
    annual_comparison_y = self.recent_order_summary(annual_comparison_y)
    annual_comparison_y = self.price_history(annual_comparison_y)

    # Print procedure.
    line_count = @data[:operations].length + 2
    y = ((@format == "1" || @data[:alternate_procedures].length == 0) ? 0.25 : 0.5) + line_count * self.class::DEFAULT_LINE_HEIGHT
    self.print_procedure y, "PROCEDURE & LOADINGS", "Primary Department", @data[:primary_department], nil, @data[:operations]

    # If part has alternate procedures, print.
    return if @format == "1"
    if @data[:alternate_procedures].length > 0
      self.start_new_page
      y = 10.25
      @data[:alternate_procedures].each do |alt|
        y = self.print_procedure y, "ALTERNATE PROCEDURE FOR DEPARTMENT #{alt[:department]}", nil, alt[:department], alt[:is_valid], alt[:operations]
      end
    end

  end

  def print_procedure(y, label, dept_label, dept, valid_badge, operations)
    thead_options = { color: "ffffff", size: 6, style: :bold, h_pad: 0.05 }
    td_options = { size: 6, font: "SF Mono", h_pad: 0.05, print_blank: true }
    line_count = operations.length + 2
    self.txtb "<u>#{label}</u>", 0.25, y, 8, self.class::DEFAULT_LINE_HEIGHT, h_align: :left, size: 8, style: :bold
    if dept && valid_badge.nil?
      self.badge  text: "#{dept_label.upcase}: #{dept}",
                  x: 8.25,
                  y: y - ((self.class::DEFAULT_LINE_HEIGHT - 0.15) / 2.0),
                  color: self.class::DEFAULT_BADGE_COLOR,
                  height: 0.15,
                  text_color: self.class::DEFAULT_BADGE_TEXT_COLOR,
                  x_align: :right
    end
    unless valid_badge.nil?
      self.badge  text: "Dept. #{dept} Procedure: #{(valid_badge ? "Valid" : "Invalid")}",
                  x: 8.25,
                  y: y - ((self.class::DEFAULT_LINE_HEIGHT - 0.15) / 2.0),
                  color: (valid_badge ? self.class::VALID_BADGE_BACKGROUND_COLOR : self.class::INVALID_BADGE_BACKGROUND_COLOR),
                  height: 0.15,
                  text_color: (valid_badge ? self.class::VALID_BADGE_TEXT_COLOR : self.class::INVALID_BADGE_TEXT_COLOR),
                  x_align: :right
    end
    y -= self.class::DEFAULT_LINE_HEIGHT
    self.rect 0.25, y, 5.05, self.class::DEFAULT_LINE_HEIGHT, fill_color: "333333", line_color: "000000", line_width: 0.005
    self.rect 5.3, y, 2.95, self.class::DEFAULT_LINE_HEIGHT, fill_color: "555555", line_color: "000000", line_width: 0.005
    self.txtb("Op".upcase, 0.25, y, 0.25, self.class::DEFAULT_LINE_HEIGHT, thead_options)
    self.txtb("Account".upcase, 0.5, y, 1.5, self.class::DEFAULT_LINE_HEIGHT, thead_options.merge({ h_align: :left }))
    self.txtb("Code".upcase, 2, y, 0.75, self.class::DEFAULT_LINE_HEIGHT, thead_options.merge({ h_align: :left }))
    self.txtb("Thickness".upcase, 2.75, y, 0.75, self.class::DEFAULT_LINE_HEIGHT, thead_options.merge({ h_align: :right }))
    self.txtb("Price".upcase, 3.5, y, 0.6, self.class::DEFAULT_LINE_HEIGHT, thead_options.merge({ h_align: :right }))
    self.txtb("Setup".upcase, 4.1, y, 0.6, self.class::DEFAULT_LINE_HEIGHT, thead_options.merge({ h_align: :right }))
    self.txtb("Minimum".upcase, 4.7, y, 0.6, self.class::DEFAULT_LINE_HEIGHT, thead_options.merge({ h_align: :right }))
    self.txtb("Pounds".upcase, 5.3, y, 0.59, self.class::DEFAULT_LINE_HEIGHT, thead_options)
    self.txtb("Amps".upcase, 5.89, y, 0.59, self.class::DEFAULT_LINE_HEIGHT, thead_options)
    self.txtb("Minutes".upcase, 6.48, y, 0.59, self.class::DEFAULT_LINE_HEIGHT, thead_options)
    self.txtb("RPM".upcase, 7.07, y, 0.59, self.class::DEFAULT_LINE_HEIGHT, thead_options)
    self.txtb("Volts".upcase, 7.66, y, 0.59, self.class::DEFAULT_LINE_HEIGHT, thead_options)
    y -= self.class::DEFAULT_LINE_HEIGHT
    save_y = y
    alt = true
    operations.each do |op|
      self.rect(0.25, y, 8, self.class::DEFAULT_LINE_HEIGHT, fill_color: "dddddd", line_color: nil) if alt
      self.txtb(op[:letter], 0.25, y, 0.25, self.class::DEFAULT_LINE_HEIGHT, td_options)
      self.txtb("#{op[:account]}: #{op[:description]}", 0.5, y, 1.5, self.class::DEFAULT_LINE_HEIGHT, td_options.merge({ h_align: :left }))
      self.txtb(op[:procedure], 2, y, 0.75, self.class::DEFAULT_LINE_HEIGHT, td_options.merge({ h_align: :left }))
      self.txtb(self.format_number(op[:thickness], decimals: 6), 2.75, y, 0.75, self.class::DEFAULT_LINE_HEIGHT, td_options.merge({ h_align: :right })) if op[:thickness] > 0
      self.txtb(op[:price], 3.5, y, 0.6, self.class::DEFAULT_LINE_HEIGHT, td_options.merge({ h_align: :right })) if op[:price] > 0
      self.txtb(self.format_number(op[:setup], decimals: 2), 4.1, y, 0.6, self.class::DEFAULT_LINE_HEIGHT, td_options.merge({ h_align: :right })) if op[:setup] > 0
      self.txtb(self.format_number(op[:minimum], decimals: 2), 4.7, y, 0.6, self.class::DEFAULT_LINE_HEIGHT, td_options.merge({ h_align: :right })) if op[:minimum] > 0
      if op[:has_loading]
        self.txtb(op[:pounds], 5.3, y, 0.59, self.class::DEFAULT_LINE_HEIGHT, td_options) if op[:pounds] > 0
        self.txtb(op[:amps], 5.89, y, 0.59, self.class::DEFAULT_LINE_HEIGHT, td_options) if op[:amps] > 0
        self.txtb(op[:minutes], 6.48, y, 0.59, self.class::DEFAULT_LINE_HEIGHT, td_options) if op[:minutes] > 0
        self.txtb(op[:rpm], 7.07, y, 0.59, self.class::DEFAULT_LINE_HEIGHT, td_options) if op[:rpm] > 0
        self.txtb(op[:volt_limit], 7.66, y, 0.59, self.class::DEFAULT_LINE_HEIGHT, td_options) if op[:volt_limit] > 0
      end
      alt = !alt
      y -= self.class::DEFAULT_LINE_HEIGHT
    end
    self.rect 0.25, save_y, 5.05, self.class::DEFAULT_LINE_HEIGHT * operations.length, line_color: "000000", line_width: 0.005
    self.rect 5.3, save_y, 2.95, self.class::DEFAULT_LINE_HEIGHT * operations.length, line_color: "000000", line_width: 0.005
    y -= (self.class::DEFAULT_LINE_HEIGHT / 2)
    return y
  end

  def procedure_badge(options = {})
    if @data[:flags][:valid_procedure]
      options[:text] = "Procedure: Valid"
      options[:color] = self.class::VALID_BADGE_BACKGROUND_COLOR
      options[:text_color] = self.class::VALID_BADGE_TEXT_COLOR
    else
      options[:text] = "Procedure: Invalid"
      options[:color] = self.class::INVALID_BADGE_BACKGROUND_COLOR
      options[:text_color] = self.class::INVALID_BADGE_TEXT_COLOR
    end
    return self.badge(options)
  end

  def price_badge(options = {})
    if @data[:flags][:valid_price]
      options[:text] = "Price: Valid"
      options[:color] = self.class::VALID_BADGE_BACKGROUND_COLOR
      options[:text_color] = self.class::VALID_BADGE_TEXT_COLOR
    else
      options[:text] = "Price: Invalid"
      options[:color] = self.class::INVALID_BADGE_BACKGROUND_COLOR
      options[:text_color] = self.class::INVALID_BADGE_TEXT_COLOR
    end
    return self.badge(options)
  end

  def automatic_pricing_badge(options = {})
    options[:color] = self.class::DEFAULT_BADGE_COLOR
    options[:text_color] = self.class::DEFAULT_BADGE_TEXT_COLOR
    if @data[:flags][:automatic_pricing]
      options[:text] = "Automatic Pricing: Yes"
    else
      options[:text] = "Automatic Pricing: No"
    end
    return self.badge(options)
  end

  def inactive_badge(options = {})
    return -1 * self.class::BADGE_SPACING unless @data[:flags][:inactive_part]
    options[:color] = self.class::DEFAULT_BADGE_COLOR
    options[:text_color] = self.class::DEFAULT_BADGE_TEXT_COLOR
    options[:text] = "Inactive Part"
    return self.badge(options)
  end

  def developmental_badge(options = {})
    return -1 * self.class::BADGE_SPACING unless @data[:flags][:developmental]
    options[:color] = self.class::DEVELOPMENTAL_BADGE_COLOR
    options[:text_color] = self.class::DEVELOPMENTAL_BADGE_TEXT_COLOR
    options[:text] = "Developmental"
    return self.badge(options)
  end

  def badge(options = {})

    # Load passed options or fall back to defaults.
    text = options.fetch(:text, nil)
    x = options.fetch(:x, nil)
    y = options.fetch(:y, nil)
    color = options.fetch(:color, nil)
    text_color = options.fetch(:text_color, "000000")
    height = options.fetch(:height, 0.15)
    style = options.fetch(:style, :bold)
    size = options.fetch(:size, 7)
    x_align = options.fetch(:x_align, :left)

    # Return if required parameter missing.
    return if text.nil? || x.nil? || y.nil? || color.nil?

    # Convert passed text to string.
    text = text.to_s.upcase
    return if text.blank?

    # Determine width.
    text_width = self.calc_width(text, size: size, style: style)

    # Change x position for right alignment if necessary.
    x -= (height.to_f + text_width.to_f) if x_align == :right

    # Print rectangle.
    self.circ x + (height.to_f / 2), y - (height.to_f / 2), (height.to_f / 2), fill_color: color, line_width: 0.005, line_color: nil
    self.circ x + text_width + (height.to_f / 2), y - (height.to_f / 2), (height.to_f / 2), fill_color: color, line_width: 0.005, line_color: nil
    self.txtb text, x + (height.to_f / 2), y, text_width, height, fill_color: color, style: style, size: size, color: text_color
    #self.hline x + (height.to_f / 2), y, text_width, line_width: 0.005
    #self.hline x + (height.to_f / 2), y - height.to_f, text_width, line_width: 0.005

    # Return total width.
    return text_width + height

  end

  def annual_comparison(y)

    # Define column widths.
    widths = [1, 0.75]
    total_width = widths[0] + widths[1] * 2

    # Define starting coordinates.
    x = 8.25 - widths[0] - widths[1] * 2
    x1 = x + widths[0]
    x2 = x1 + widths[1]

    # Print table.
    self.txtb "<u>ANNUAL COMPARISON</u>", x, y, total_width, self.class::DEFAULT_LINE_HEIGHT, size: 8, style: :bold, h_align: :left
    y -= self.class::DEFAULT_LINE_HEIGHT
    self.txtb "YTD".upcase, x1, y, widths[1], self.class::DEFAULT_LINE_HEIGHT, fill_color: "333333", line_color: "000000", color: "ffffff", size: 6, style: :bold, line_width: 0.005
    self.txtb "Last Year".upcase, x2, y, widths[1], self.class::DEFAULT_LINE_HEIGHT, fill_color: "333333", line_color: "000000", color: "ffffff", size: 6, style: :bold, line_width: 0.005
    y -= self.class::DEFAULT_LINE_HEIGHT
    self.rect x, y, total_width, self.class::DEFAULT_LINE_HEIGHT, fill_color: "dddddd", line_color: nil
    self.txtb "# Orders".upcase, x, y, widths[0], self.class::DEFAULT_LINE_HEIGHT, line_color: "000000", size: 6, style: :bold, line_width: 0.005, h_align: :left, h_pad: 0.05
    self.txtb self.format_number(@data[:ytd][:orders]), x1, y, widths[1], self.class::DEFAULT_LINE_HEIGHT, line_color: "000000", size: 6, line_width: 0.005, h_align: :right, h_pad: 0.05, font: "SF Mono"
    self.txtb self.format_number(@data[:last_year][:orders]), x2, y, widths[1], self.class::DEFAULT_LINE_HEIGHT, line_color: "000000", size: 6, line_width: 0.005, h_align: :right, h_pad: 0.05, font: "SF Mono"
    y -= self.class::DEFAULT_LINE_HEIGHT
    self.rect x, y, widths[0], 1.75 * self.class::DEFAULT_LINE_HEIGHT, line_width: 0.005
    self.rect x1, y, widths[1], 1.75 * self.class::DEFAULT_LINE_HEIGHT, line_width: 0.005
    self.rect x2, y, widths[1], 1.75 * self.class::DEFAULT_LINE_HEIGHT, line_width: 0.005
    self.txtb "Sales".upcase, x, y, widths[0], self.class::DEFAULT_LINE_HEIGHT, size: 6, style: :bold, line_width: 0.005, h_align: :left, h_pad: 0.05
    self.txtb "Total".upcase, x, y, widths[0], self.class::DEFAULT_LINE_HEIGHT, size: 6, style: :normal, line_width: 0.005, h_align: :right, h_pad: 0.05
    self.txtb self.format_number(@data[:ytd][:sales], decimals: 2), x1, y, widths[1], self.class::DEFAULT_LINE_HEIGHT, size: 6, h_align: :right, h_pad: 0.05, font: "SF Mono"
    self.txtb self.format_number(@data[:last_year][:sales], decimals: 2), x2, y, widths[1], self.class::DEFAULT_LINE_HEIGHT, size: 6, h_align: :right, h_pad: 0.05, font: "SF Mono"
    y -= self.class::DEFAULT_LINE_HEIGHT * 0.75
    self.txtb "Avg / Order".upcase, x, y, widths[0], self.class::DEFAULT_LINE_HEIGHT, size: 6, style: :normal, line_width: 0.005, h_align: :right, h_pad: 0.05
    self.txtb self.format_number(@data[:ytd][:orders] == 0 ? 0 : @data[:ytd][:sales].to_f / @data[:ytd][:orders].to_f, decimals: 2), x1, y, widths[1], self.class::DEFAULT_LINE_HEIGHT, size: 6, h_align: :right, h_pad: 0.05, font: "SF Mono"
    self.txtb self.format_number(@data[:last_year][:orders] == 0 ? 0 : @data[:last_year][:sales].to_f / @data[:last_year][:orders].to_f, decimals: 2), x2, y, widths[1], self.class::DEFAULT_LINE_HEIGHT, size: 6, h_align: :right, h_pad: 0.05, font: "SF Mono"
    y -= self.class::DEFAULT_LINE_HEIGHT
    self.rect x, y, total_width, 1.75 * self.class::DEFAULT_LINE_HEIGHT, fill_color: "dddddd", line_color: nil
    self.rect x, y, widths[0], 1.75 * self.class::DEFAULT_LINE_HEIGHT, line_width: 0.005
    self.rect x1, y, widths[1], 1.75 * self.class::DEFAULT_LINE_HEIGHT, line_width: 0.005
    self.rect x2, y, widths[1], 1.75 * self.class::DEFAULT_LINE_HEIGHT, line_width: 0.005
    self.txtb "Pieces".upcase, x, y, widths[0], self.class::DEFAULT_LINE_HEIGHT, size: 6, style: :bold, line_width: 0.005, h_align: :left, h_pad: 0.05
    self.txtb "Total".upcase, x, y, widths[0], self.class::DEFAULT_LINE_HEIGHT, size: 6, style: :normal, line_width: 0.005, h_align: :right, h_pad: 0.05
    self.txtb self.format_number(@data[:ytd][:pieces], decimals: 0), x1, y, widths[1], self.class::DEFAULT_LINE_HEIGHT, size: 6, h_align: :right, h_pad: 0.05, font: "SF Mono"
    self.txtb self.format_number(@data[:last_year][:pieces], decimals: 0), x2, y, widths[1], self.class::DEFAULT_LINE_HEIGHT, size: 6, h_align: :right, h_pad: 0.05, font: "SF Mono"
    y -= self.class::DEFAULT_LINE_HEIGHT * 0.75
    self.txtb "Avg / Order".upcase, x, y, widths[0], self.class::DEFAULT_LINE_HEIGHT, size: 6, style: :normal, line_width: 0.005, h_align: :right, h_pad: 0.05
    self.txtb self.format_number(@data[:ytd][:orders] == 0 ? 0 : @data[:ytd][:pieces].to_f / @data[:ytd][:orders].to_f, decimals: 0), x1, y, widths[1], self.class::DEFAULT_LINE_HEIGHT, size: 6, h_align: :right, h_pad: 0.05, font: "SF Mono"
    self.txtb self.format_number(@data[:last_year][:orders] == 0 ? 0 : @data[:last_year][:pieces].to_f / @data[:last_year][:orders].to_f, decimals: 0), x2, y, widths[1], self.class::DEFAULT_LINE_HEIGHT, size: 6, h_align: :right, h_pad: 0.05, font: "SF Mono"
    y -= self.class::DEFAULT_LINE_HEIGHT
    self.rect x, y, widths[0], 1.75 * self.class::DEFAULT_LINE_HEIGHT, line_width: 0.005
    self.rect x1, y, widths[1], 1.75 * self.class::DEFAULT_LINE_HEIGHT, line_width: 0.005
    self.rect x2, y, widths[1], 1.75 * self.class::DEFAULT_LINE_HEIGHT, line_width: 0.005
    self.txtb "Pounds".upcase, x, y, widths[0], self.class::DEFAULT_LINE_HEIGHT, size: 6, style: :bold, line_width: 0.005, h_align: :left, h_pad: 0.05
    self.txtb "Total".upcase, x, y, widths[0], self.class::DEFAULT_LINE_HEIGHT, size: 6, style: :normal, line_width: 0.005, h_align: :right, h_pad: 0.05
    self.txtb self.format_number(@data[:ytd][:pounds], decimals: 0), x1, y, widths[1], self.class::DEFAULT_LINE_HEIGHT, size: 6, h_align: :right, h_pad: 0.05, font: "SF Mono"
    self.txtb self.format_number(@data[:last_year][:pounds], decimals: 0), x2, y, widths[1], self.class::DEFAULT_LINE_HEIGHT, size: 6, h_align: :right, h_pad: 0.05, font: "SF Mono"
    y -= self.class::DEFAULT_LINE_HEIGHT * 0.75
    self.txtb "Avg / Order".upcase, x, y, widths[0], self.class::DEFAULT_LINE_HEIGHT, size: 6, style: :normal, line_width: 0.005, h_align: :right, h_pad: 0.05
    self.txtb self.format_number(@data[:ytd][:orders] == 0 ? 0 : @data[:ytd][:pounds].to_f / @data[:ytd][:orders].to_f, decimals: 0), x1, y, widths[1], self.class::DEFAULT_LINE_HEIGHT, size: 6, h_align: :right, h_pad: 0.05, font: "SF Mono"
    self.txtb self.format_number(@data[:last_year][:orders] == 0 ? 0 : @data[:last_year][:pounds].to_f / @data[:last_year][:orders].to_f, decimals: 0), x2, y, widths[1], self.class::DEFAULT_LINE_HEIGHT, size: 6, h_align: :right, h_pad: 0.05, font: "SF Mono"
    y -= self.class::DEFAULT_LINE_HEIGHT
    self.rect x, y, total_width, 2.5 * self.class::DEFAULT_LINE_HEIGHT, fill_color: "dddddd", line_color: nil
    self.rect x, y, widths[0], 2.5 * self.class::DEFAULT_LINE_HEIGHT, line_width: 0.005
    self.rect x1, y, widths[1], 2.5 * self.class::DEFAULT_LINE_HEIGHT, line_width: 0.005
    self.rect x2, y, widths[1], 2.5 * self.class::DEFAULT_LINE_HEIGHT, line_width: 0.005
    self.txtb "Rework".upcase, x, y, widths[0], self.class::DEFAULT_LINE_HEIGHT, size: 6, style: :bold, line_width: 0.005, h_align: :left, h_pad: 0.05
    self.txtb "Cost".upcase, x, y, widths[0], self.class::DEFAULT_LINE_HEIGHT, size: 6, style: :normal, line_width: 0.005, h_align: :right, h_pad: 0.05
    self.txtb self.format_number(@data[:ytd][:rework], decimals: 2), x1, y, widths[1], self.class::DEFAULT_LINE_HEIGHT, size: 6, h_align: :right, h_pad: 0.05, font: "SF Mono"
    self.txtb self.format_number(@data[:last_year][:rework], decimals: 2), x2, y, widths[1], self.class::DEFAULT_LINE_HEIGHT, size: 6, h_align: :right, h_pad: 0.05, font: "SF Mono"
    y -= self.class::DEFAULT_LINE_HEIGHT * 0.75
    self.txtb "# Orders".upcase, x, y, widths[0], self.class::DEFAULT_LINE_HEIGHT, size: 6, style: :normal, line_width: 0.005, h_align: :right, h_pad: 0.05
    self.txtb self.format_number(@data[:ytd][:rework_orders], decimals: 0), x1, y, widths[1], self.class::DEFAULT_LINE_HEIGHT, size: 6, h_align: :right, h_pad: 0.05, font: "SF Mono"
    self.txtb self.format_number(@data[:last_year][:rework_orders], decimals: 0), x2, y, widths[1], self.class::DEFAULT_LINE_HEIGHT, size: 6, h_align: :right, h_pad: 0.05, font: "SF Mono"
    y -= self.class::DEFAULT_LINE_HEIGHT * 0.75
    self.txtb "% Sales".upcase, x, y, widths[0], self.class::DEFAULT_LINE_HEIGHT, size: 6, style: :normal, line_width: 0.005, h_align: :right, h_pad: 0.05
    self.txtb "#{self.format_number(@data[:ytd][:sales] == 0 ? 0 : 100 * @data[:ytd][:rework].to_f / @data[:ytd][:sales].to_f, decimals: 3)}%", x1, y, widths[1], self.class::DEFAULT_LINE_HEIGHT, size: 6, h_align: :right, h_pad: 0.05, font: "SF Mono"
    self.txtb "#{self.format_number(@data[:last_year][:sales] == 0 ? 0 : 100 * @data[:last_year][:rework].to_f / @data[:last_year][:sales].to_f, decimals: 3)}%", x2, y, widths[1], self.class::DEFAULT_LINE_HEIGHT, size: 6, h_align: :right, h_pad: 0.05, font: "SF Mono"
    y -= self.class::DEFAULT_LINE_HEIGHT * 0.75

    # Return y position.
    y -= self.class::DEFAULT_LINE_HEIGHT
    return y

  end

  def recent_order_summary(y)

    # Define column widths.
    widths = [1, 0.75, 0.75]
    total_width = widths[0] + widths[1] + widths[2]

    # Define starting coordinates.
    x = 8.25 - widths[0] - widths[1] - widths[2]
    x1 = x + widths[0]
    x2 = x1 + widths[1]

    # Print table.
    self.txtb "<u>MOST RECENT ORDERS</u>", x, y, total_width, self.class::DEFAULT_LINE_HEIGHT, size: 8, style: :bold, h_align: :left
    y -= self.class::DEFAULT_LINE_HEIGHT
    self.txtb "Date".upcase, x, y, widths[0], self.class::DEFAULT_LINE_HEIGHT, fill_color: "333333", line_color: "000000", color: "ffffff", size: 6, style: :bold, line_width: 0.005
    self.txtb "S.O. #".upcase, x1, y, widths[1], self.class::DEFAULT_LINE_HEIGHT, fill_color: "333333", line_color: "000000", color: "ffffff", size: 6, style: :bold, line_width: 0.005
    self.txtb "# Orders".upcase, x2, y, widths[2], self.class::DEFAULT_LINE_HEIGHT, fill_color: "333333", line_color: "000000", color: "ffffff", size: 6, style: :bold, line_width: 0.005
    alt = true
    y -= self.class::DEFAULT_LINE_HEIGHT
    @data[:last_used].each do |info|
      self.rect(x, y, total_width, self.class::DEFAULT_LINE_HEIGHT, fill_color: "dddddd", line_color: nil) if alt
      self.txtb Date.parse(info[:date]).strftime("%m/%d/%y"), x, y, widths[0], self.class::DEFAULT_LINE_HEIGHT, line_color: "000000", size: 6, line_width: 0.005, h_pad: 0.05, font: "SF Mono"
      self.txtb info[:shop_order], x1, y, widths[1], self.class::DEFAULT_LINE_HEIGHT, line_color: "000000", size: 6, line_width: 0.005, h_pad: 0.05, font: "SF Mono"
      self.txtb self.format_number(info[:order_count]), x2, y, widths[2], self.class::DEFAULT_LINE_HEIGHT, line_color: "000000", size: 6, line_width: 0.005, h_pad: 0.05, font: "SF Mono"
      alt = !alt
      y -= self.class::DEFAULT_LINE_HEIGHT
    end

    # Return y position.
    y -= self.class::DEFAULT_LINE_HEIGHT
    return y

  end

  def download_to_tempfile(url)
    uri = URI.parse(url)
    Net::HTTP.start(uri.host, uri.port) do |http|
      resp = http.get(uri.path)
      file = Tempfile.new('shop_order')
      file.binmode
      file.write(resp.body)
      file.flush
      file
    end
  end

  def draw_photo(y)

    # Attempt to load photo.
    found_photo = false
    url, photo = nil
    ["jpg", "png"].each do |extension|
      url = "http://so.varland.com/so_photos/#{@data[:control_number]}.#{extension}";
      photo = self.download_to_tempfile(url)
      if photo.size >= 10.kilobytes
        found_photo = true
        break
      end
    end

    # If no photo found, return.
    return y unless found_photo

    # Draw heading.
    self.txtb "<u>PART PHOTO</u>", 6.45, y, 1.8, self.class::DEFAULT_LINE_HEIGHT, size: 8, style: :bold, h_align: :left
    y -= self.class::DEFAULT_LINE_HEIGHT

    # Read image dimensions and calculate rendered size.
    photo_width, photo_height = FastImage.size(photo.path)
    photo_ratio = photo_height.to_f / photo_width.to_f
    render_width = 1.8
    render_height = photo_ratio * 1.8
    if render_height > 2
      render_height = 2
      render_width = render_height / photo_ratio
    end

    # Determine position.
    x_buffer = (1.8 - render_width) * 0.5
    y_buffer = (2 - render_height) * 0.5
    photo_x = 6.45 + x_buffer
    photo_y = y - y_buffer

    # Draw photo centered in box.
    self.image(photo.path, at: [photo_x.in, photo_y.in], width: render_width.in, height: render_height.in)
    self.rect photo_x, photo_y, 1.8, 2, line_width: 0.005

    # Return success.
    y -= (2 + self.class::DEFAULT_LINE_HEIGHT)
    return y

  end

  def price_history(y)

    # Return if no history.
    return if @data[:price][:history].length == 0

    # Define column widths.
    widths = [0.75, 0.75, 0.5, 0.5]
    total_width = widths[0] + widths[1] + widths[2] + widths[3]

    # Define starting coordinates.
    x = 8.25 - total_width
    x1 = x + widths[0]
    x2 = x1 + widths[1]
    x3 = x2 + widths[2]

    # Print table.
    self.txtb "<u>PRICE HISTORY</u>", x, y, total_width, self.class::DEFAULT_LINE_HEIGHT, size: 8, style: :bold, h_align: :left
    y -= self.class::DEFAULT_LINE_HEIGHT
    self.txtb "Date".upcase, x, y, widths[0], self.class::DEFAULT_LINE_HEIGHT, fill_color: "333333", line_color: "000000", color: "ffffff", size: 6, style: :bold, line_width: 0.005
    self.txtb "Price".upcase, x1, y, widths[1], self.class::DEFAULT_LINE_HEIGHT, fill_color: "333333", line_color: "000000", color: "ffffff", size: 6, style: :bold, line_width: 0.005
    self.txtb "Setup".upcase, x2, y, widths[2], self.class::DEFAULT_LINE_HEIGHT, fill_color: "333333", line_color: "000000", color: "ffffff", size: 6, style: :bold, line_width: 0.005
    self.txtb "Min".upcase, x3, y, widths[3], self.class::DEFAULT_LINE_HEIGHT, fill_color: "333333", line_color: "000000", color: "ffffff", size: 6, style: :bold, line_width: 0.005
    alt = true
    y -= self.class::DEFAULT_LINE_HEIGHT
    @data[:price][:history].each do |info|
      self.rect(x, y, total_width, self.class::DEFAULT_LINE_HEIGHT, fill_color: "dddddd", line_color: nil) if alt
      self.txtb Date.parse(info[:date]).strftime("%m/%d/%y"), x, y, widths[0], self.class::DEFAULT_LINE_HEIGHT, line_color: "000000", size: 6, line_width: 0.005, h_pad: 0.05, font: "SF Mono"
      self.txtb "$#{info[:price] == 0 ? "–" : info[:price]}/#{info[:per].downcase}", x1, y, widths[1], self.class::DEFAULT_LINE_HEIGHT, line_color: "000000", size: 6, line_width: 0.005, h_pad: 0.05, font: "SF Mono"
      self.txtb "$#{info[:setup] == 0 ? "–" : info[:setup]}", x2, y, widths[2], self.class::DEFAULT_LINE_HEIGHT, line_color: "000000", size: 6, line_width: 0.005, h_pad: 0.05, font: "SF Mono"
      self.txtb "$#{info[:minimum] == 0 ? "–" : info[:minimum]}", x3, y, widths[3], self.class::DEFAULT_LINE_HEIGHT, line_color: "000000", size: 6, line_width: 0.005, h_pad: 0.05, font: "SF Mono"
      alt = !alt
      y -= self.class::DEFAULT_LINE_HEIGHT
    end

    # Return y position.
    y -= self.class::DEFAULT_LINE_HEIGHT
    return y

  end

end