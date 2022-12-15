class FinancialReportPdf < ::VarlandPdf

  PAGE_ORIENTATION = :landscape
  LINE_HEIGHT = 0.135

  def initialize(file)

    # Initialize report.
    super()
    @report_title = nil
    @report_month = nil
    @report_year = nil

    # Load data.
    @file = file
    self.load_data
    self.split_data

    # Print data.
    self.print_data

    # Print header and title on all pages.
    self.repeat(:all) do

      # Draw title & logo.
      self.logo(0.25, 8, 10.5, 0.5, variant: :stacked, mono: false, h_align: :right)
      self.txtb("#{@report_title}\n<font size=\"11\">#{@report_month} #{@report_year}</font>", 0.25, 8, 10.5, 0.5, h_align: :left, style: :bold, size: 14)

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
    @lines = File.readlines(@file)
  end

  def split_data
    @pages = []
    current_page = []
    current_line = 0
    line4 = nil
    line5 = nil
    @lines.each do |line|
      current_line += 1
      if line.match(/PAGE\s+\d+/)
        @pages << current_page if current_page.length > 0
        current_line = 1
        current_page = []
      end
      case current_line
      when 1, 4, 5
        # Ignore
      when 2
        @report_title = line.strip if @report_title.blank?
      when 3
        if @report_month.blank? && @report_year.blank?
          matches = line.match(/FOR\s+(\w+)\s+(\d+)/)
          @report_month = matches[1]
          @report_year = matches[2].to_i
        end
      when 6
        line4 = line #.gsub("\n",'')
      when 7
        line5 = line #.gsub("\n",'')
        current_page << self.format_column_headers(line4, line5)
      else
        current_page << self.format_leading_spaces(line) #.gsub("\n",''))
      end
    end
    @pages << current_page if current_page.length > 0
  end

  def format_column_headers(line4, line5)
    formatted = line5.gsub("\n", "")
    formatted2 = ""
    line4_bytes = line4.bytes
    (0...line4.length).each do |i|
      if line4_bytes[i] >= 33 && line4_bytes[i] <= 126
        formatted[i] = line4_bytes[i].chr
      end
    end
    formatted_bytes = formatted.bytes
    (0...formatted_bytes.length).each do |i|
      if i != 0 && formatted_bytes[i] == 32 && formatted_bytes[i - 1] != 32
        formatted2 << "</u>"
      end
      formatted2 << formatted_bytes[i].chr
      if (i != formatted_bytes.length - 1) && formatted_bytes[i] == 32 && formatted_bytes[i + 1] != 32
        formatted2 << "<u>"
      end
    end
    formatted2 << "</u>"
    return self.format_leading_spaces(formatted2.gsub("_", " "))
  end

  def format_leading_spaces(line)
    formatted_line = ""
    line.bytes.each do |byte|
      case byte
      when 32
        formatted_line << " "
      else
        formatted_line << byte.chr
      end
    end
    formatted_line = " " if formatted_line.strip  == ".........."
    negatives = formatted_line.scan(/[\d,]*\.\d+-/)
    if negatives.length > 0
      negatives.each do |num|
        formatted_line.gsub!(num, "<color rgb='ff0000'>#{num}</color>")
      end
    end
    return formatted_line
  end

  def print_data
    printed_data = false
    @pages.each do |page_lines|
      self.start_new_page if printed_data
      printed_data = true
      y = 7.25
      page_lines.each do |line|
        self.txtb line,
                  0.25,
                  y,
                  10.5,
                  FinancialReportPdf::LINE_HEIGHT,
                  h_align: :left,
                  v_align: :top,
                  font: "SF Mono",
                  size: 8
        y -= FinancialReportPdf::LINE_HEIGHT
      end
    end
  end

end