class AS400::PartSpecPdf < ::VarlandPdf

  PAGE_ORIENTATION = :landscape
  BADGE_SPACING = 0.05
  VALID_BADGE_BACKGROUND_COLOR = "000000"
  VALID_BADGE_TEXT_COLOR = "ffffff"
  INVALID_BADGE_BACKGROUND_COLOR = "f55d3e"
  INVALID_BADGE_TEXT_COLOR = "ffffff"
  DEVELOPMENTAL_BADGE_COLOR = "3c91e6"
  DEVELOPMENTAL_BADGE_TEXT_COLOR = "ffffff"
  DEFAULT_BADGE_COLOR = "dddddd"
  DEFAULT_BADGE_TEXT_COLOR = "000000"
  PART_NAME_LINE_HEIGHT = 0.175
  DEFAULT_LINE_HEIGHT = 0.2
  HIGHLIGHTED_FIELD_TEXT_COLOR = "ff0000"

  def initialize(customer, process, part, sub, format)

    # Initialize report.
    super()

    # Store params.
    @customer = customer
    @process = process
    @part = part
    @sub = sub
    @format = format.upcase

    # Load data.
    self.load_data

    # Print data.
    self.print_data
    self.print_part_history_notes
    self.print_sales_history_notes

    # Print header and title on all pages.
    timestamp = Time.current.strftime "%m/%d/%y %-l:%M:%S%P"
    self.repeat(:all, dynamic: true) do

      # Draw logo & title.
      self.logo(0.25, self.page_number.to_i == 1 ? 8 : 8.25, 10.5, 0.4, variant: :mark, mono: true, h_align: :left)
      keys = [@customer, @process, @part]
      keys << @sub unless @sub.blank?
      self.txtb("<strong>#{keys.join("</strong> / <strong>")}</strong> <font size='9'>#{@data[:customer_name]}</font>", 0.7, self.page_number.to_i == 1 ? 8 : 8.25, 8.5, self.page_number.to_i == 1 ? 0.25 : 0.4, h_align: :left, style: :normal, size: 14, v_align: (self.page_number.to_i == 1 ? :top : :center))

      # Draw update information.
      self.txtb "Last Update".upcase, 9.05, self.page_number.to_i == 1 ? 8 : 8.25, 1.7, 0.2, fill_color: "333333", color: "ffffff", size: 6, style: :bold, line_color: "000000", line_width: 0.005
      update_time = Time.parse(@data[:update_info][:timestamp])
      self.txtb "#{@data[:update_info][:operator]}:#{@data[:update_info][:authorizer]}", 9.05, self.page_number.to_i == 1 ? 7.8 : 8.05, 0.5, 0.2, size: 6, line_color: "000000", h_pad: 0.05, line_width: 0.005, font: "SF Mono"
      self.txtb update_time.strftime("%m/%d/%y"), 9.55, self.page_number.to_i == 1 ? 7.8 : 8.05, 0.6, 0.2, size: 6, line_color: "000000", h_pad: 0.05, line_width: 0.005, font: "SF Mono"
      self.txtb update_time.strftime("%H:%M:%S"), 10.15, self.page_number.to_i == 1 ? 7.8 : 8.05, 0.6, 0.2, size: 6, line_color: "000000", h_pad: 0.05, line_width: 0.005, font: "SF Mono"

      # Draw date/time printed & number pages.
      self.txtb(timestamp, 0.25, 0.5, 10.5, 0.25, h_align: :left, size: 6, font: self.class::DEFAULT_FONT_FAMILY, v_align: :bottom)
      self.txtb("Page #{self.page_number} of #{self.page_count}", 0.25, 0.5, 10.5, 0.25, h_align: :right, size: 6, font: self.class::DEFAULT_FONT_FAMILY, v_align: :bottom) unless self.page_count == 1

    end

    # First page specific header.
    self.repeat([1]) do

      # Draw badges.
      badge_x = 0.7
      badge_x += self.procedure_badge(x: badge_x, y: 7.75) + self.class::BADGE_SPACING
      badge_x += self.price_badge(x: badge_x, y: 7.75) + self.class::BADGE_SPACING
      badge_x += self.inactive_badge(x: badge_x, y: 7.75) + self.class::BADGE_SPACING
      self.developmental_badge(x: badge_x, y: 7.75)

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

  def print_sales_history_notes
    return unless @format == "L" || @format == "T"
    start_pages = self.page_count
    self.start_new_page
    y = 7.75 - self.class::DEFAULT_LINE_HEIGHT
    self.font_size(7.5)
    self.fill_color("000000")
    self.font("SF Mono", style: :normal)
    notes = []
    @data[:sales_history_notes].each do |note|
      notes << "<font size=\'6\' name=\'Helvetica\''><color rgb=\'555555\'>#{Date.parse(note[:date]).strftime("%m/%d/%y")}:</color></font>\n<strong>#{note[:lines].join("\n")}</strong>"
    end
    notes << "\n<color rgb=\'555555\'><font name='Helvetica'><em>No notes available.</em></font></color>" if notes.length == 0
    text = notes.join("\n\n")
    column_box([0.25.in, y.in], width: 10.5.in, height: (y - 0.5).in, columns: 2) do
      self.text text, inline_format: true
    end
    end_pages = self.page_count
    total_count = end_pages - start_pages
    self.repeat((start_pages + 1)..end_pages, dynamic: true) do
      self.txtb "<strong><u>CUSTOMER SALES HISTORY NOTES</u></strong> (Page #{self.page_number - start_pages} of #{total_count})", 0.25, 7.75, 8, self.class::DEFAULT_LINE_HEIGHT, size: 8, style: :normal, h_align: :left
    end
  end

  def print_part_history_notes
    return unless @format == "L" || @format == "S"
    start_pages = self.page_count
    self.start_new_page
    y = 7.75- self.class::DEFAULT_LINE_HEIGHT
    self.font_size(7.5)
    self.fill_color("000000")
    self.font("SF Mono", style: :normal)
    notes = []
    @data[:part_history_notes].each do |note|
      notes << "<font size=\'6\' name=\'Helvetica\''><color rgb=\'555555\'>#{Date.parse(note[:date]).strftime("%m/%d/%y")} (pg. #{note[:page]}):</color></font>\n<strong>#{note[:lines].join("\n")}</strong>"
    end
    notes << "\n<color rgb=\'555555\'><font name='Helvetica'><em>No notes available.</em></font></color>" if notes.length == 0
    text = notes.join("\n\n")
    column_box([0.25.in, y.in], width: 10.5.in, height: (y - 0.5).in, columns: 2) do
      self.text text, inline_format: true
    end
    end_pages = self.page_count
    total_count = end_pages - start_pages
    self.repeat((start_pages + 1)..end_pages, dynamic: true) do
      self.txtb "<strong><u>PART HISTORY NOTES</u></strong> (Page #{self.page_number - start_pages} of #{total_count})", 0.25, 7.75, 8, self.class::DEFAULT_LINE_HEIGHT, size: 8, style: :normal, h_align: :left
    end
  end

  def print_data

    # Print part name, description, process spec, and application.
    y = 7.5
    self.txtb "Part Name:".upcase, 0.25, y, 2.5, self.class::PART_NAME_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    self.txtb "Part Description:".upcase, 3, y, 2.5, self.class::PART_NAME_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
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
    @data[:part_description].each do |line|
      self.txtb line, 3, process_spec_y, 2.5, self.class::PART_NAME_LINE_HEIGHT, size: 7, h_align: :left, font: "SF Mono", style: :bold
      process_spec_y -= self.class::PART_NAME_LINE_HEIGHT
    end
    part_description_y = part_name_y - self.class::PART_NAME_LINE_HEIGHT * 2
    self.txtb "Process Specification:".upcase, 0.25, part_description_y, 2.5, self.class::PART_NAME_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    part_description_y -= self.class::PART_NAME_LINE_HEIGHT
    @data[:process_spec].each do |line|
      self.txtb line, 0.25, part_description_y, 2.5, self.class::PART_NAME_LINE_HEIGHT, size: 7, h_align: :left, font: "SF Mono", style: :bold
      part_description_y -= self.class::PART_NAME_LINE_HEIGHT
    end
    #unless @data[:application].length == 0
    #  self.txtb "Application:".upcase, 5.75, application_y, 2.5, self.class::PART_NAME_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    #  application_y -= self.class::PART_NAME_LINE_HEIGHT
    #  @data[:application].each do |line|
    #    self.txtb line, 5.75, application_y, 2.5, self.class::PART_NAME_LINE_HEIGHT, size: 7, h_align: :left, font: "SF Mono", style: :bold
    #    application_y -= self.class::PART_NAME_LINE_HEIGHT
    #  end
    #end

    # Update y position.
    y = [part_description_y, process_spec_y, application_y].min - self.class::DEFAULT_LINE_HEIGHT
    annual_comparison_y = y
    other_properties_y = y
    area_y = process_spec_y - self.class::DEFAULT_LINE_HEIGHT * 2

    # Print other part properties.
    #self.txtb "<u>PART AREA & WEIGHT</u>", 3, area_y, 4, self.class::PART_NAME_LINE_HEIGHT, size: 8, style: :bold, h_align: :left
    #self.txtb "<u>PART CALCULATIONS</u>", 2.75, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, size: 8, style: :bold, h_align: :left
    #area_y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb "AREA: <strong><font name='SF Mono' size='7'><color rgb='#{self.class::HIGHLIGHTED_FIELD_TEXT_COLOR}'>#{@data[:area][:value]} #{@data[:area][:unit] == 'F' ? 'ft' : 'in'}<sup>2</sup>/#{@data[:area][:per] == 'E' ? 'pc' : 'lb'}</color></font></strong>", 3, area_y, 1.375, self.class::PART_NAME_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    self.txtb "PC. WT: <strong><font name='SF Mono' size='7'><color rgb='#{self.class::HIGHLIGHTED_FIELD_TEXT_COLOR}'>#{@data[:piece_weight]} lbs</color></font></strong>", 4.375, area_y, 1.375, self.class::PART_NAME_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    self.txtb "FT<sup>3</sup>: <strong><font name='SF Mono' size='7'><color rgb='#{self.class::HIGHLIGHTED_FIELD_TEXT_COLOR}'>#{@data[:pounds_per_cubic]} lbs/ft<sup>3</sup></color></font></strong>", 5.75, area_y, 1.375, self.class::PART_NAME_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    area_y -= self.class::PART_NAME_LINE_HEIGHT * 3
    self.txtb "PCS / LB: <strong><font name='SF Mono' size='7'>#{@data[:pcs_per_lb]}</font></strong>", 3, area_y, 1.375, self.class::PART_NAME_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    self.txtb "LBS / M: <strong><font name='SF Mono' size='7'>#{@data[:lbs_per_thousand]}</font></strong>", 4.375, area_y, 4, self.class::PART_NAME_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    self.txtb "FT<sup>2</sup> / LB: <strong><font name='SF Mono' size='7'>#{@data[:square_feet_per_lb]}</font></strong>", 5.75, area_y, 4, self.class::PART_NAME_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    self.txtb "FT<sup>2</sup> / M: <strong><font name='SF Mono' size='7'>#{@data[:square_feet_per_thousand]}</font></strong>", 7.125, area_y, 4, self.class::PART_NAME_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    area_y -= self.class::PART_NAME_LINE_HEIGHT * 3
    self.txtb "SCHEDULE CODE: <strong><font name='SF Mono' size='7'>#{@data[:schedule_code].nil? ? " " : @data[:schedule_code]}</font></strong>", 3, area_y, 2.75, self.class::PART_NAME_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    self.txtb "BASE METAL: <strong><font name='SF Mono' size='7'>#{@data[:base_metal].nil? ? " " : @data[:base_metal]}</font></strong>", 5.75, area_y, 2.75, self.class::PART_NAME_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    area_y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb "EQUIPMENT USED: <strong><font name='SF Mono' size='7'>#{@data[:equipment_used].length == 0 ? " " : @data[:equipment_used][0]}</font></strong>", 3, area_y, 5.5, self.class::PART_NAME_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    area_y -= self.class::PART_NAME_LINE_HEIGHT
    if @data[:equipment_used].length > 1
      self.txtb "<color rgb='ffffff'>EQUIPMENT USED:</color> <strong><font name='SF Mono' size='7'>#{@data[:equipment_used][1]}</font></strong>", 3, area_y, 5.5, self.class::PART_NAME_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
      area_y -= self.class::PART_NAME_LINE_HEIGHT
    end
    #other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    #self.txtb "GRAMS PER PIECE: <strong><font name='SF Mono' size='7'>#{@data[:piece_weight_grams]} g/pc</font></strong>", 2.75, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    #other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    #self.txtb "SQUARE CM PER PIECE: <strong><font name='SF Mono' size='7'>#{@data[:square_cm_per_piece]} cm<sup>2</sup>/pc</font></strong>", 2.75, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    #other_properties_y -= self.class::PART_NAME_LINE_HEIGHT

    #other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    #self.txtb "<u>OTHER PART INFORMATION</u>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, size: 8, style: :bold, h_align: :left
    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb "CERTIFY CODE: <strong><font name='SF Mono' size='7'>#{@data[:certify_code].nil? ? " " : @data[:certify_code]}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    #self.txtb "SCHEDULE CODE: <strong><font name='SF Mono' size='7'>#{@data[:schedule_code].nil? ? " " : @data[:schedule_code]}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    #other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    #self.txtb "BASE METAL: <strong><font name='SF Mono' size='7'>#{@data[:base_metal].nil? ? " " : @data[:base_metal]}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    #other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb "HOW SHIPPED: <strong><font name='SF Mono' size='7'>#{@data[:how_shipped].nil? ? " " : @data[:how_shipped]}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb "PRINT ID: <strong><font name='SF Mono' size='7'>#{@data[:print_id].nil? ? " " : @data[:print_id]}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    #self.txtb "EQUIPMENT USED: <strong><font name='SF Mono' size='7'>#{@data[:equipment_used].length == 0 ? " " : @data[:equipment_used][0]}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    #other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    #if @data[:equipment_used].length > 1
    #  self.txtb "<color rgb='ffffff'>EQUIPMENT USED:</color> <strong><font name='SF Mono' size='7'>#{@data[:equipment_used][1]}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    #  other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    #end

    #other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    #self.txtb "<u>PRICING INFORMATION</u>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, size: 8, style: :bold, h_align: :left
    #self.txtb("<u>QUOTATION INFORMATION</u>", 2.75, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, size: 8, style: :bold, h_align: :left) unless @data[:quote][:number].nil? || @data[:quote][:number].to_i == 0
    #other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    #self.txtb "PRICE: <strong><font name='SF Mono' size='7'>$#{@data[:price][:price]}/#{@data[:price][:per].downcase} #{@data[:price][:price_date].nil? ? "" : Date.parse(@data[:price][:price_date]).strftime("(%m/%d/%y)")}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    #self.txtb("QUOTE #: <strong><font name='SF Mono' size='7'>#{@data[:quote][:number]}</font></strong>", 2.75, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left) unless @data[:quote][:number].nil? || @data[:quote][:number].to_i == 0
    #other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    #self.txtb "SETUP: <strong><font name='SF Mono' size='7'>$#{@data[:price][:setup]} #{@data[:price][:setup_date].nil? ? "" : Date.parse(@data[:price][:setup_date]).strftime("(%m/%d/%y)")}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    #self.txtb("VALID: <strong><font name='SF Mono' size='7'>#{@data[:quote][:valid] ? "YES" : "NO"}</font></strong>", 2.75, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left) unless @data[:quote][:number].nil? || @data[:quote][:number].to_i == 0
    #other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    #self.txtb "MINIMUM: <strong><font name='SF Mono' size='7'>$#{@data[:price][:minimum]} #{@data[:price][:minimum_date].nil? ? "" : Date.parse(@data[:price][:minimum_date]).strftime("(%m/%d/%y)")}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    #self.txtb("EFFECTIVE DATE: <strong><font name='SF Mono' size='7'>#{Date.parse(@data[:quote][:effective_date]).strftime("%m/%d/%y")}</font></strong>", 2.75, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left) unless @data[:quote][:number].nil? || @data[:quote][:number].to_i == 0
    #other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    #self.txtb "DIFFICULTY FACTOR: <strong><font name='SF Mono' size='7'>#{@data[:price][:difficulty_factor]}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    #self.txtb("PRICE: <strong><font name='SF Mono' size='7'>$#{@data[:quote][:price]}/#{@data[:quote][:per].downcase}</font></strong>", 2.75, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left) unless @data[:quote][:number].nil? || @data[:quote][:number].to_i == 0
    #other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    #self.txtb("SETUP: <strong><font name='SF Mono' size='7'>$#{@data[:quote][:setup]}</font></strong>", 2.75, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left) unless @data[:quote][:number].nil? || @data[:quote][:number].to_i == 0
    #other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    #self.txtb("MINIMUM: <strong><font name='SF Mono' size='7'>$#{@data[:quote][:minimum]}</font></strong>", 2.75, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left) unless @data[:quote][:number].nil? || @data[:quote][:number].to_i == 0
    #other_properties_y -= self.class::PART_NAME_LINE_HEIGHT

    #unless @data[:remarks].nil? && @data[:review_date].nil?
    #  other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    #  self.txtb "<u>REMARKS & REVIEW</u>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, size: 8, style: :bold, h_align: :left
    #  other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    #  unless @data[:remarks].nil?
    #    self.txtb "REMARKS: <strong><font name='SF Mono' size='7'>#{@data[:remarks]}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    #    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    #  end
    #  unless @data[:review_date].nil?
    #    self.txtb "REVIEW DATE: <strong><font name='SF Mono' size='7'>#{Date.parse(@data[:review_date]).strftime("%m/%d/%y")}</font></strong>", 0.25, other_properties_y, 4, self.class::DEFAULT_LINE_HEIGHT, style: :normal, size: 6, h_align: :left
    #    other_properties_y -= self.class::PART_NAME_LINE_HEIGHT
    #  end
    #end

    # Print annual comparison & last few orders summary.
    #annual_comparison_y = self.draw_photo(annual_comparison_y)
    #annual_comparison_y = self.annual_comparison(annual_comparison_y)
    annual_comparison_y = self.recent_order_summary(other_properties_y - self.class::PART_NAME_LINE_HEIGHT * 2)
    #annual_comparison_y = self.price_history(annual_comparison_y)

    # Print procedure.
    line_count = @data[:operations].length + 2
    y = 0.5 + line_count * self.class::DEFAULT_LINE_HEIGHT
    self.print_procedure y, "PROCEDURE & LOADINGS", "Primary Department", @data[:primary_department], nil, @data[:operations]

    # If part has alternate procedures, print.
    return if @format == "1"
    if @data[:alternate_procedures].length > 0
      self.start_new_page
      y = 7.75
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
                  x: 6.45,
                  y: y - ((self.class::DEFAULT_LINE_HEIGHT - 0.15) / 2.0),
                  color: self.class::DEFAULT_BADGE_COLOR,
                  height: 0.15,
                  text_color: self.class::DEFAULT_BADGE_TEXT_COLOR,
                  x_align: :right
    end
    unless valid_badge.nil?
      self.badge  text: "Dept. #{dept} Procedure: #{(valid_badge ? "Valid" : "Invalid")}",
                  x: 6.45,
                  y: y - ((self.class::DEFAULT_LINE_HEIGHT - 0.15) / 2.0),
                  color: (valid_badge ? self.class::VALID_BADGE_BACKGROUND_COLOR : self.class::INVALID_BADGE_BACKGROUND_COLOR),
                  height: 0.15,
                  text_color: (valid_badge ? self.class::VALID_BADGE_TEXT_COLOR : self.class::INVALID_BADGE_TEXT_COLOR),
                  x_align: :right
    end
    y -= self.class::DEFAULT_LINE_HEIGHT
    self.rect 0.25, y, 6.2, self.class::DEFAULT_LINE_HEIGHT, fill_color: "333333", line_color: "000000", line_width: 0.005
    #self.rect 5.3, y, 2.95, self.class::DEFAULT_LINE_HEIGHT, fill_color: "555555", line_color: "000000", line_width: 0.005
    self.txtb("Op".upcase, 0.25, y, 0.25, self.class::DEFAULT_LINE_HEIGHT, thead_options)
    self.txtb("Account".upcase, 0.5, y, 1.5, self.class::DEFAULT_LINE_HEIGHT, thead_options.merge({ h_align: :left }))
    self.txtb("Code".upcase, 2, y, 0.75, self.class::DEFAULT_LINE_HEIGHT, thead_options.merge({ h_align: :left }))
    self.txtb("Thickness".upcase, 2.75, y, 0.75, self.class::DEFAULT_LINE_HEIGHT, thead_options.merge({ h_align: :right }))
    #self.txtb("Price".upcase, 3.5, y, 0.6, self.class::DEFAULT_LINE_HEIGHT, thead_options.merge({ h_align: :right }))
    #self.txtb("Setup".upcase, 4.1, y, 0.6, self.class::DEFAULT_LINE_HEIGHT, thead_options.merge({ h_align: :right }))
    #self.txtb("Minimum".upcase, 4.7, y, 0.6, self.class::DEFAULT_LINE_HEIGHT, thead_options.merge({ h_align: :right }))
    self.txtb("Pounds".upcase, 3.5, y, 0.59, self.class::DEFAULT_LINE_HEIGHT, thead_options)
    self.txtb("Amps".upcase, 4.09, y, 0.59, self.class::DEFAULT_LINE_HEIGHT, thead_options)
    self.txtb("Minutes".upcase, 4.68, y, 0.59, self.class::DEFAULT_LINE_HEIGHT, thead_options)
    self.txtb("RPM".upcase, 5.27, y, 0.59, self.class::DEFAULT_LINE_HEIGHT, thead_options)
    self.txtb("Volts".upcase, 5.86, y, 0.59, self.class::DEFAULT_LINE_HEIGHT, thead_options)
    y -= self.class::DEFAULT_LINE_HEIGHT
    save_y = y
    alt = true
    operations.each do |op|
      self.rect(0.25, y, 6.2, self.class::DEFAULT_LINE_HEIGHT, fill_color: "dddddd", line_color: nil) if alt
      self.txtb(op[:letter], 0.25, y, 0.25, self.class::DEFAULT_LINE_HEIGHT, td_options)
      self.txtb("#{op[:account]}: #{op[:description]}", 0.5, y, 1.5, self.class::DEFAULT_LINE_HEIGHT, td_options.merge({ h_align: :left }))
      self.txtb(op[:procedure], 2, y, 0.75, self.class::DEFAULT_LINE_HEIGHT, td_options.merge({ h_align: :left }))
      self.txtb(self.format_number(op[:thickness], decimals: 6), 2.75, y, 0.75, self.class::DEFAULT_LINE_HEIGHT, td_options.merge({ h_align: :right })) if op[:thickness] > 0
      #self.txtb(op[:price], 3.5, y, 0.6, self.class::DEFAULT_LINE_HEIGHT, td_options.merge({ h_align: :right })) if op[:price] > 0
      #self.txtb(self.format_number(op[:setup], decimals: 2), 4.1, y, 0.6, self.class::DEFAULT_LINE_HEIGHT, td_options.merge({ h_align: :right })) if op[:setup] > 0
      #self.txtb(self.format_number(op[:minimum], decimals: 2), 4.7, y, 0.6, self.class::DEFAULT_LINE_HEIGHT, td_options.merge({ h_align: :right })) if op[:minimum] > 0
      if op[:has_loading]
        self.txtb(op[:pounds], 3.5, y, 0.59, self.class::DEFAULT_LINE_HEIGHT, td_options) if op[:pounds] > 0
        self.txtb(op[:amps], 4.09, y, 0.59, self.class::DEFAULT_LINE_HEIGHT, td_options) if op[:amps] > 0
        self.txtb(op[:minutes], 4.68, y, 0.59, self.class::DEFAULT_LINE_HEIGHT, td_options) if op[:minutes] > 0
        self.txtb(op[:rpm], 5.27, y, 0.59, self.class::DEFAULT_LINE_HEIGHT, td_options) if op[:rpm] > 0
        self.txtb(op[:volt_limit], 5.86, y, 0.59, self.class::DEFAULT_LINE_HEIGHT, td_options) if op[:volt_limit] > 0
      end
      alt = !alt
      y -= self.class::DEFAULT_LINE_HEIGHT
    end
    self.rect 0.25, save_y, 6.2, self.class::DEFAULT_LINE_HEIGHT * operations.length, line_color: "000000", line_width: 0.005
    #self.rect 5.3, save_y, 2.95, self.class::DEFAULT_LINE_HEIGHT * operations.length, line_color: "000000", line_width: 0.005
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

  def recent_order_summary(y)

    # Define column widths.
    widths = [1, 0.75, 0.75]
    total_width = widths[0] + widths[1] + widths[2]

    # Define starting coordinates.
    x = 0.25 #8.25 - widths[0] - widths[1] - widths[2]
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

end