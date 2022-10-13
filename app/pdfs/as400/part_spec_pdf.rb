class AS400::PartSpecPdf < ::VarlandPdf

  PAGE_ORIENTATION = :landscape
  BADGE_SPACING = 0.05
  VALID_BADGE_BACKGROUND_COLOR = "149911"
  VALID_BADGE_TEXT_COLOR = "ffffff"
  INVALID_BADGE_BACKGROUND_COLOR = "f55d3e"
  INVALID_BADGE_TEXT_COLOR = "ffffff"
  DEVELOPMENTAL_BADGE_COLOR = "3c91e6"
  DEVELOPMENTAL_BADGE_TEXT_COLOR = "ffffff"
  DEFAULT_BADGE_COLOR = "dddddd"
  DEFAULT_BADGE_TEXT_COLOR = "000000"
  PART_NAME_LINE_HEIGHT = 0.15

  def initialize(customer, process, part, sub)

    # Initialize report.
    super()

    # Store params.
    @customer = customer
    @process = process
    @part = part
    @sub = sub

    # Load data.
    self.load_data

    # Print data.
    self.print_data

    # Print header and title on all pages.
    self.repeat(:all) do

      # Draw header & logo.
      self.logo(0.25, 8.25, 10.5, 0.4, variant: :mark, mono: false, h_align: :left)
      keys = [@customer, @process, @part]
      keys << @sub unless @sub.blank?
      self.txtb("<strong>#{keys.join("</strong> / <strong>")}</strong> <font size='9'>#{@data[:customer_name]}</font>", 0.7, 8.25, 10.5, 0.25, h_align: :left, style: :normal, size: 16, v_align: :top)
      badge_x = 0.7
      badge_x += self.procedure_badge(x: badge_x, y: 8) + self.class::BADGE_SPACING
      badge_x += self.price_badge(x: badge_x, y: 8) + self.class::BADGE_SPACING
      badge_x += self.automatic_pricing_badge(x: badge_x, y: 8) + self.class::BADGE_SPACING
      badge_x += self.inactive_badge(x: badge_x, y: 8) + self.class::BADGE_SPACING
      self.developmental_badge(x: badge_x, y: 8)

      # Draw update information.
      self.txtb "Last Update".upcase, 8.95, 8.25, 1.8, 0.2, fill_color: "333333", color: "ffffff", size: 6, style: :bold, line_color: "000000"
      update_time = Time.parse(@data[:update_info][:timestamp])
      self.txtb "#{@data[:update_info][:operator]}:#{@data[:update_info][:authorizer]}", 8.95, 8.05, 0.6, 0.2, size: 7, line_color: "000000", h_pad: 0.05
      self.txtb update_time.strftime("%m/%d/%y"), 9.55, 8.05, 0.6, 0.2, size: 7, line_color: "000000", h_pad: 0.05
      self.txtb update_time.strftime("%H:%I:%M"), 10.15, 8.05, 0.6, 0.2, size: 7, line_color: "000000", h_pad: 0.05

    end

    # Number pages.
    if self.page_count > 1
      string = "Page <page> of <total>"
      options = { at: [0.25.in, 0.5.in],
                  width: 10.5.in,
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
    y = 7.75
    self.txtb "Part Name".upcase, 0.25, y, 3.5, self.class::PART_NAME_LINE_HEIGHT, style: :bold, fill_color: "333333", color: "ffffff", line_color: "000000", size: 6, h_align: :left, h_pad: 0.05
    self.txtb "Process Specification".upcase, 3.75, y, 3.5, self.class::PART_NAME_LINE_HEIGHT, style: :bold, fill_color: "333333", color: "ffffff", line_color: "000000", size: 6, h_align: :left, h_pad: 0.05
    self.txtb "Industry".upcase, 7.25, y, 1.75, self.class::PART_NAME_LINE_HEIGHT, style: :bold, fill_color: "333333", color: "ffffff", line_color: "000000", size: 6, h_align: :left, h_pad: 0.05
    self.txtb "Sub-Industry".upcase, 9, y, 1.75, self.class::PART_NAME_LINE_HEIGHT, style: :bold, fill_color: "333333", color: "ffffff", line_color: "000000", size: 6, h_align: :left, h_pad: 0.05
    y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb @data[:part_name].join("\n"), 0.25, y, 3.5, self.class::PART_NAME_LINE_HEIGHT * 4, size: 7, h_align: :left, v_align: :top, h_pad: 0.05, v_pad: 0.05, line_color: "000000", print_blank: true
    self.txtb @data[:process_spec].join("\n"), 3.75, y, 3.5, self.class::PART_NAME_LINE_HEIGHT * 9, size: 7, h_align: :left, v_align: :top, h_pad: 0.05, v_pad: 0.05, line_color: "000000", print_blank: true
    self.txtb @data[:industry], 7.25, y, 1.75, self.class::PART_NAME_LINE_HEIGHT, size: 7, h_align: :left, h_pad: 0.05, v_align: :center, line_color: "000000", print_blank: true
    self.txtb @data[:sub_industry], 9, y, 1.75, self.class::PART_NAME_LINE_HEIGHT, size: 7, h_align: :left, h_pad: 0.05, v_align: :center, line_color: "000000", print_blank: true
    y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb "Application".upcase, 7.25, y, 3.5, self.class::PART_NAME_LINE_HEIGHT, style: :bold, fill_color: "333333", color: "ffffff", line_color: "000000", size: 6, h_align: :left, h_pad: 0.05
    y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb @data[:application].join("\n"), 7.25, y, 3.5, self.class::PART_NAME_LINE_HEIGHT * 7, size: 7, h_align: :left, v_align: :top, h_pad: 0.05, v_pad: 0.05, line_color: "000000", print_blank: true
    y -= self.class::PART_NAME_LINE_HEIGHT * 2
    self.txtb "Part Description".upcase, 0.25, y, 3.5, self.class::PART_NAME_LINE_HEIGHT, style: :bold, fill_color: "333333", color: "ffffff", line_color: "000000", size: 6, h_align: :left, h_pad: 0.05
    y -= self.class::PART_NAME_LINE_HEIGHT
    self.txtb @data[:part_description].join("\n"), 0.25, y, 3.5, self.class::PART_NAME_LINE_HEIGHT * 4, size: 7, h_align: :left, v_align: :top, h_pad: 0.05, v_pad: 0.05, line_color: "000000", print_blank: true

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

    # Return if required parameter missing.
    return if text.nil? || x.nil? || y.nil? || color.nil?

    # Convert passed text to string.
    text = text.to_s.upcase
    return if text.blank?

    # Determine width.
    text_width = self.calc_width(text, size: size, style: style)

    # Print rectangle.
    self.draw_circle x + (height.to_f / 2), y - (height.to_f / 2), (height.to_f / 2), fill_color: color, line_color: nil
    self.draw_circle x + text_width + (height.to_f / 2), y - (height.to_f / 2), (height.to_f / 2), fill_color: color, line_color: nil
    self.txtb text, x + (height.to_f / 2), y, text_width, height, fill_color: color, style: style, size: size, color: text_color

    # Return total width.
    return text_width + height

  end

end