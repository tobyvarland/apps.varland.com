class FinancialReportPdf < ::VarlandPdf

  PAGE_ORIENTATION = :landscape
  LINE_HEIGHT = 0.16

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
      self.logo(0.25, 8, 10.5, 0.5, variant: :stacked, mono: true, h_align: :right)
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
    @lines.each do |line|
      current_line += 1
      if line.match(/PAGE\s+\d+/)
        @pages << current_page if current_page.length > 0
        current_line = 1
        current_page = []
      end
      case current_line
      when 1, 4
        # Ignore lines
      when 2
        @report_title = line.strip if @report_title.blank?
      when 3
        if @report_month.blank? && @report_year.blank?
          matches = line.match(/FOR\s+(\w+)\s+(\d+)/)
          @report_month = matches[1]
          @report_year = matches[2].to_i
        end
      else
        current_page << self.format_leading_spaces(line)
      end
    end
    @pages << current_page if current_page.length > 0
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