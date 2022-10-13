class AS400::MonthlyDepartmentCostReportPdf < ::VarlandPdf

  PAGE_ORIENTATION = :landscape
  DEPT_HEADER_HEIGHT = 0.25
  DEPT_BUFFER_HEIGHT = 0.1
  TABLE_ROW_HEIGHT = 0.15
  SECTION_BUFFER_WIDTH = 0.1
  PRODUCTION_AMOUNT_WIDTH = 0.45
  MATERIALS_AMOUNT_WIDTH = 0.45
  MATERIALS_PERCENT_WIDTH = 0.45
  WAGES_AMOUNT_WIDTH = 0.45
  WAGES_PERCENT_WIDTH = 0.45
  DIRECT_COST_PERCENT_WIDTH = 0.45
  DESCRIPTION_WIDTH = 2.1
  ALT_ROW_BACKGROUND_COLOR = "eeeeee"
  TOTAL_ROW_BACKGROUND_COLOR = "cccccc"
  SHOW_CURRENCY_SIGN = false
  DEFAULT_CELL_PADDING = 0.015
  TOTAL_ROW_STYLE = :bold
  TABLE_DATA_FONT_SIZE = 5.5
  PERCENT_HIGHLIGHT_LEVEL = 0.5
  PERCENT_HIGHLIGHT_COLOR = "ff0000"
  PERCENT_HIGHLIGHT_BACKGROUND_COLOR = nil

  def initialize()

    # Initialize report.
    super()

    # Load data.
    self.load_data
    #puts @data

    # Print data.
    self.print_data

    # Print header and title on all pages.
    self.repeat(:all) do

      # Draw title & logo.
      self.logo(0.25, 8, 10.5, 0.5, variant: :stacked, mono: true, h_align: :right)
      last_month = Date.current.advance(months: -1)
      self.txtb("Monthly Department Cost Report (With Setups)\n<font size=\"11\">#{last_month.strftime "%B %Y"}</font>", 0.25, 8, 10.5, 0.5, h_align: :left, style: :bold, size: 14)

    end

    # Number pages.
    if self.page_count > 1
      string = "<i>Page <page> of <total></i>"
      options = { at: [0.25.in, 0.5.in],
                  width: 10.5.in,
                  height: 0.25.in,
                  align: :center,
                  size: 8,
                  start_count_at: 1,
                  valign: :center,
                  inline_format: true }
      self.number_pages(string, options)
    end

  end

  def load_data
    uri = URI.parse("http://json400.varland.com/monthly_department_cost_report")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    @data = nil unless response.code.to_s == "200"
    @data = JSON.parse(response.body, symbolize_names: true)
  end

  def print_data

    # Set starting Y position.
    y = 7.25

    # Print each department.
    @data[:departments].each do |department|
      y = print_department(department, y)
    end

    # Print department summary.
    self.print_department_summary

  end

  def print_department_summary

    # Start new page for department summary.
    self.start_new_page
    y = 7.25

    # Print table header.
    self.print_table_header(y, "Department")
    y -= 2 * self.class::TABLE_ROW_HEIGHT

    # Print department totals.
    grand_total_production = [0, 0, 0]
    grand_total_materials = [0, 0, 0]
    grand_total_wages = [0, 0, 0]
    alt = true
    @data[:departments].each do |department|
      alt = !alt
      grand_total_production[0] += department[:production_1_month]
      grand_total_production[1] += department[:production_4_months]
      grand_total_production[2] += department[:production_12_months]
      grand_total_materials[0] += department[:materials_1_month]
      grand_total_materials[1] += department[:materials_4_months]
      grand_total_materials[2] += department[:materials_12_months]
      grand_total_wages[0] += department[:wages_1_month]
      grand_total_wages[1] += department[:wages_4_months]
      grand_total_wages[2] += department[:wages_12_months]
      self.print_row  y,
                      background: alt ? self.class::ALT_ROW_BACKGROUND_COLOR : nil,
                      description: "Dept. #{department[:number]} – #{department[:name]}",
                      production: [department[:production_1_month],
                                   department[:production_4_months],
                                   department[:production_12_months]],
                      materials: [department[:materials_1_month],
                                  department[:materials_4_months],
                                  department[:materials_12_months]],
                      wages: [department[:wages_1_month],
                              department[:wages_4_months],
                              department[:wages_12_months]]
      y -= self.class::TABLE_ROW_HEIGHT
    end
    self.print_row  y,
                    style: self.class::TOTAL_ROW_STYLE,
                    background: self.class::TOTAL_ROW_BACKGROUND_COLOR,
                    description: "Totals",
                    description_alignment: :right,
                    production: grand_total_production,
                    materials: grand_total_materials,
                    wages: grand_total_wages

  end

  def print_department(department, y)

    # Calculate height for department. Start new page if necessary.
    dept_height = self.class::DEPT_HEADER_HEIGHT + 3 * self.class::TABLE_ROW_HEIGHT
    @data[:accounts].each do |acct|
      dept_height += self.class::TABLE_ROW_HEIGHT if acct[:department] == department[:number]
    end
    if y - dept_height < 0.5
      self.start_new_page
      y = 7.25
    end

    # Print department name header.
    self.txtb("Dept. #{department[:number]}: #{department[:name]}",
              0.25,
              y,
              10.5,
              self.class::DEPT_HEADER_HEIGHT,
              h_align: :left,
              style: :bold,
              size: 8)
    y -= self.class::DEPT_HEADER_HEIGHT

    # Print table header.
    self.print_table_header(y, "Cost Center")
    y -= 2 * self.class::TABLE_ROW_HEIGHT

    # Print each account.
    alt = true
    @data[:accounts].each do |acct|
      next unless acct[:department] == department[:number]
      alt = !alt
      self.print_row  y,
                      background: alt ? self.class::ALT_ROW_BACKGROUND_COLOR : nil,
                      description: "#{acct[:number]} – #{acct[:name]}",
                      production: [acct[:production_1_month],
                                   acct[:production_4_months],
                                   acct[:production_12_months]],
                      materials: [acct[:materials_1_month],
                                  acct[:materials_4_months],
                                  acct[:materials_12_months]]
      y -= self.class::TABLE_ROW_HEIGHT
    end

    # Print department totals.
    self.print_row  y,
                    style: self.class::TOTAL_ROW_STYLE,
                    background: self.class::TOTAL_ROW_BACKGROUND_COLOR,
                    description: "Totals",
                    description_alignment: :right,
                    production: [department[:production_1_month],
                                 department[:production_4_months],
                                 department[:production_12_months]],
                    materials: [department[:materials_1_month],
                                department[:materials_4_months],
                                department[:materials_12_months]],
                    wages: [department[:wages_1_month],
                            department[:wages_4_months],
                            department[:wages_12_months]]
    y -= self.class::TABLE_ROW_HEIGHT

    # Return new Y position.
    y -= self.class::DEPT_BUFFER_HEIGHT
    return y

  end

  def print_table_header(y, description)
    self.txtb(description,
              0.25,
              y,
              self.class::DESCRIPTION_WIDTH,
              2 * self.class::TABLE_ROW_HEIGHT,
              h_align: :left,
              style: :bold,
              h_pad: 0.1,
              line_color: "000000",
              fill_color: "333333",
              color: "ffffff",
              size: 7)
    self.txtb("Month to Date",
              self.get_x_for_column(1),
              y,
              self.class::PRODUCTION_AMOUNT_WIDTH + self.class::MATERIALS_AMOUNT_WIDTH + self.class::MATERIALS_PERCENT_WIDTH + self.class::WAGES_AMOUNT_WIDTH + self.class::WAGES_PERCENT_WIDTH + self.class::DIRECT_COST_PERCENT_WIDTH,
              self.class::TABLE_ROW_HEIGHT,
              h_align: :center,
              style: :bold,
              fill_color: "333333",
              color: "ffffff",
              size: 7)
    self.txtb("Last 4 Months",
              self.get_x_for_column(2),
              y,
              self.class::PRODUCTION_AMOUNT_WIDTH + self.class::MATERIALS_AMOUNT_WIDTH + self.class::MATERIALS_PERCENT_WIDTH + self.class::WAGES_AMOUNT_WIDTH + self.class::WAGES_PERCENT_WIDTH + self.class::DIRECT_COST_PERCENT_WIDTH,
              self.class::TABLE_ROW_HEIGHT,
              h_align: :center,
              style: :bold,
              fill_color: "333333",
              color: "ffffff",
              size: 7)
    self.txtb("Last 12 Months",
              self.get_x_for_column(3),
              y,
              self.class::PRODUCTION_AMOUNT_WIDTH + self.class::MATERIALS_AMOUNT_WIDTH + self.class::MATERIALS_PERCENT_WIDTH + self.class::WAGES_AMOUNT_WIDTH + self.class::WAGES_PERCENT_WIDTH + self.class::DIRECT_COST_PERCENT_WIDTH,
              self.class::TABLE_ROW_HEIGHT,
              h_align: :center,
              style: :bold,
              fill_color: "333333",
              color: "ffffff",
              size: 7)

    [1, 2, 3].each do |col|
      x = self.get_x_for_column(col)
      self.txtb("Production",
                x,
                y - self.class::TABLE_ROW_HEIGHT,
                self.class::PRODUCTION_AMOUNT_WIDTH,
                self.class::TABLE_ROW_HEIGHT,
                h_align: :center,
                style: :bold,
                h_pad: self.class::DEFAULT_CELL_PADDING,
                fill_color: "333333",
                color: "ffffff",
                size: 6)
      self.txtb("Materials",
                x + self.class::PRODUCTION_AMOUNT_WIDTH,
                y - self.class::TABLE_ROW_HEIGHT,
                self.class::MATERIALS_AMOUNT_WIDTH + self.class::MATERIALS_PERCENT_WIDTH,
                self.class::TABLE_ROW_HEIGHT,
                h_align: :center,
                style: :bold,
                h_pad: self.class::DEFAULT_CELL_PADDING,
                fill_color: "333333",
                color: "ffffff",
                size: 5.5)
      self.txtb("Wages",
                x + self.class::PRODUCTION_AMOUNT_WIDTH + self.class::MATERIALS_AMOUNT_WIDTH + self.class::MATERIALS_PERCENT_WIDTH,
                y - self.class::TABLE_ROW_HEIGHT,
                self.class::WAGES_AMOUNT_WIDTH + self.class::WAGES_PERCENT_WIDTH,
                self.class::TABLE_ROW_HEIGHT,
                h_align: :center,
                style: :bold,
                h_pad: self.class::DEFAULT_CELL_PADDING,
                fill_color: "333333",
                color: "ffffff",
                size: 5.5)
      self.txtb("Total",
                x + self.class::PRODUCTION_AMOUNT_WIDTH + self.class::MATERIALS_AMOUNT_WIDTH + self.class::MATERIALS_PERCENT_WIDTH + self.class::WAGES_AMOUNT_WIDTH + self.class::WAGES_PERCENT_WIDTH,
                y - self.class::TABLE_ROW_HEIGHT,
                self.class::DIRECT_COST_PERCENT_WIDTH,
                self.class::TABLE_ROW_HEIGHT,
                h_align: :center,
                style: :bold,
                h_pad: self.class::DEFAULT_CELL_PADDING,
                fill_color: "333333",
                color: "ffffff",
                size: 5.5)
      self.rect(x, y, self.class::PRODUCTION_AMOUNT_WIDTH + self.class::MATERIALS_AMOUNT_WIDTH + self.class::MATERIALS_PERCENT_WIDTH + self.class::WAGES_AMOUNT_WIDTH + self.class::WAGES_PERCENT_WIDTH + self.class::DIRECT_COST_PERCENT_WIDTH, 2 * self.class::TABLE_ROW_HEIGHT)
    end
  end

  def get_x_for_column(column)
    return case column
           when 1 then 0.25 + self.class::DESCRIPTION_WIDTH + self.class::SECTION_BUFFER_WIDTH
           when 2 then 0.25 + self.class::DESCRIPTION_WIDTH + self.class::SECTION_BUFFER_WIDTH * 2 + self.class::PRODUCTION_AMOUNT_WIDTH + self.class::MATERIALS_AMOUNT_WIDTH + self.class::MATERIALS_PERCENT_WIDTH + self.class::WAGES_AMOUNT_WIDTH + self.class::WAGES_PERCENT_WIDTH + self.class::DIRECT_COST_PERCENT_WIDTH
           when 3 then 0.25 + self.class::DESCRIPTION_WIDTH + self.class::SECTION_BUFFER_WIDTH * 3 + self.class::PRODUCTION_AMOUNT_WIDTH * 2 + self.class::MATERIALS_AMOUNT_WIDTH * 2 + self.class::MATERIALS_PERCENT_WIDTH * 2 + self.class::WAGES_AMOUNT_WIDTH * 2 + self.class::WAGES_PERCENT_WIDTH * 2 + self.class::DIRECT_COST_PERCENT_WIDTH * 2
           end
  end

  def production_box(amount, column, y, style = :normal)
    return if !amount || amount == 0
    x = self.get_x_for_column(column)
    if self.class::SHOW_CURRENCY_SIGN
      self.txtb("$",
                x,
                y,
                self.class::PRODUCTION_AMOUNT_WIDTH,
                self.class::TABLE_ROW_HEIGHT,
                h_align: :left,
                h_pad: self.class::DEFAULT_CELL_PADDING,
                size: self.class::TABLE_DATA_FONT_SIZE,
                style: style)
    end
    self.txtb(self.format_number(amount),
              x,
              y,
              self.class::PRODUCTION_AMOUNT_WIDTH,
              self.class::TABLE_ROW_HEIGHT,
              h_align: :right,
              h_pad: self.class::DEFAULT_CELL_PADDING,
              size: self.class::TABLE_DATA_FONT_SIZE,
              style: style)
  end

  def materials_box(amount, column, y, style = :normal)
    return if !amount || amount == 0
    x = self.get_x_for_column(column) + self.class::PRODUCTION_AMOUNT_WIDTH
    if self.class::SHOW_CURRENCY_SIGN
      self.txtb("$",
                x,
                y,
                self.class::MATERIALS_AMOUNT_WIDTH,
                self.class::TABLE_ROW_HEIGHT,
                h_align: :left,
                h_pad: self.class::DEFAULT_CELL_PADDING,
                size: self.class::TABLE_DATA_FONT_SIZE,
                style: style)
    end
    self.txtb(self.format_number(amount),
              x,
              y,
              self.class::MATERIALS_AMOUNT_WIDTH,
              self.class::TABLE_ROW_HEIGHT,
              h_align: :right,
              h_pad: self.class::DEFAULT_CELL_PADDING,
              size: self.class::TABLE_DATA_FONT_SIZE,
              style: style)
  end

  def materials_percent_box(materials, production, column, y, style = :normal)
    return if production.nil? || production <= 0 || materials <= 0
    x = self.get_x_for_column(column) + self.class::PRODUCTION_AMOUNT_WIDTH + self.class::MATERIALS_AMOUNT_WIDTH
    percent = materials.to_f / production.to_f
    color = percent >= self.class::PERCENT_HIGHLIGHT_LEVEL ? self.class::PERCENT_HIGHLIGHT_COLOR : "000000"
    fill_color = percent >= self.class::PERCENT_HIGHLIGHT_LEVEL ? self.class::PERCENT_HIGHLIGHT_BACKGROUND_COLOR : nil
    self.txtb("#{self.format_number(100 * percent, decimals: 1)}%",
              x,
              y,
              self.class::MATERIALS_PERCENT_WIDTH,
              self.class::TABLE_ROW_HEIGHT,
              h_align: :right,
              h_pad: self.class::DEFAULT_CELL_PADDING,
              size: self.class::TABLE_DATA_FONT_SIZE,
              style: style,
              color: color,
              fill_color: fill_color)
  end

  def wages_box(amount, column, y, style = :normal)
    return if !amount || amount == 0
    x = self.get_x_for_column(column) + self.class::PRODUCTION_AMOUNT_WIDTH + self.class::MATERIALS_AMOUNT_WIDTH + self.class::MATERIALS_PERCENT_WIDTH
    if self.class::SHOW_CURRENCY_SIGN
      self.txtb("$",
                x,
                y,
                self.class::WAGES_AMOUNT_WIDTH,
                self.class::TABLE_ROW_HEIGHT,
                h_align: :left,
                h_pad: self.class::DEFAULT_CELL_PADDING,
                size: self.class::TABLE_DATA_FONT_SIZE,
                style: style)
    end
    self.txtb(self.format_number(amount),
              x,
              y,
              self.class::WAGES_AMOUNT_WIDTH,
              self.class::TABLE_ROW_HEIGHT,
              h_align: :right,
              h_pad: self.class::DEFAULT_CELL_PADDING,
              size: self.class::TABLE_DATA_FONT_SIZE,
              style: style)
  end

  def wages_percent_box(wages, production, column, y, style = :normal)
    return if production.nil? || production <= 0 || wages <= 0
    x = self.get_x_for_column(column) + self.class::PRODUCTION_AMOUNT_WIDTH + self.class::MATERIALS_AMOUNT_WIDTH + self.class::MATERIALS_PERCENT_WIDTH + self.class::WAGES_AMOUNT_WIDTH
    percent = wages.to_f / production.to_f
    color = percent >= self.class::PERCENT_HIGHLIGHT_LEVEL ? self.class::PERCENT_HIGHLIGHT_COLOR : "000000"
    fill_color = percent >= self.class::PERCENT_HIGHLIGHT_LEVEL ? self.class::PERCENT_HIGHLIGHT_BACKGROUND_COLOR : nil
    self.txtb("#{self.format_number(100 * percent, decimals: 1)}%",
              x,
              y,
              self.class::WAGES_PERCENT_WIDTH,
              self.class::TABLE_ROW_HEIGHT,
              h_align: :right,
              h_pad: self.class::DEFAULT_CELL_PADDING,
              size: self.class::TABLE_DATA_FONT_SIZE,
              style: style,
              color: color,
              fill_color: fill_color)
  end

  def direct_cost_percent_box(materials, wages, production, column, y, style = :normal)
    return if production.nil? || production <= 0
    total = materials.to_f
    total += wages.to_f unless wages.nil?
    return if total <= 0
    x = self.get_x_for_column(column) + self.class::PRODUCTION_AMOUNT_WIDTH + self.class::MATERIALS_AMOUNT_WIDTH + self.class::MATERIALS_PERCENT_WIDTH + self.class::WAGES_AMOUNT_WIDTH + self.class::WAGES_PERCENT_WIDTH
    percent = total.to_f / production.to_f
    color = percent >= self.class::PERCENT_HIGHLIGHT_LEVEL ? self.class::PERCENT_HIGHLIGHT_COLOR : "000000"
    fill_color = percent >= self.class::PERCENT_HIGHLIGHT_LEVEL ? self.class::PERCENT_HIGHLIGHT_BACKGROUND_COLOR : nil
    self.txtb("#{self.format_number(100 * percent, decimals: 1)}%",
              x,
              y,
              self.class::DIRECT_COST_PERCENT_WIDTH,
              self.class::TABLE_ROW_HEIGHT,
              h_align: :right,
              h_pad: self.class::DEFAULT_CELL_PADDING,
              size: self.class::TABLE_DATA_FONT_SIZE,
              style: style,
              color: color,
              fill_color: fill_color)
  end

  def description_box(text, y, style = :normal, align = :left)
    self.txtb(text,
              0.25,
              y,
              self.class::DESCRIPTION_WIDTH,
              self.class::TABLE_ROW_HEIGHT,
              h_align: align,
              h_pad: 0.1,
              size: self.class::TABLE_DATA_FONT_SIZE,
              style: style)
  end

  def print_row(y, options = {})
    style = options.fetch(:style, :normal)
    background = options.fetch(:background, nil)
    description = options.fetch(:description, nil)
    description_alignment = options.fetch(:description_alignment, :left)
    production = options.fetch(:production, [0, 0, 0])
    materials = options.fetch(:materials, [0, 0, 0])
    wages = options.fetch(:wages, [nil, nil, nil])
    if background
      self.rect(0.25, y, 10.5, self.class::TABLE_ROW_HEIGHT, fill_color: background, line_color: nil)
    end
    if description
      self.description_box(description, y, style, description_alignment)
    end
    [0, 1, 2].each do |i|
      self.production_box(production[i], i + 1, y, style)
      self.materials_box(materials[i], i + 1, y, style)
      self.materials_percent_box(materials[i], production[i], i + 1, y, style)
      self.wages_box(wages[i], i + 1, y, style) unless wages[i].nil?
      self.wages_percent_box(wages[i], production[i], i + 1, y, style) unless wages[i].nil?
      self.direct_cost_percent_box(materials[i], wages[i], production[i], i + 1, y, style)
    end
  end

end