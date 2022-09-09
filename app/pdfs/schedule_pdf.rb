class SchedulePdf < ::VarlandPdf

  EMPLOYEE_NAME_WIDTH = 1
  TOTAL_HOURS_WIDTH = 0.5
  SCHEDULE_WIDTH = 11
  BLOCK_TIME_HEIGHT = 0.6
  EMPLOYEE_ROW_HEIGHT = 0.25
  TOTAL_ROW_HEIGHT = 0.4
  SCHEDULE_BOX_HEIGHT_BUFFER = 0.03

  PAGE_ORIENTATION = :landscape
  PAGE_SIZE = [612.00, SchedulePdf::SCHEDULE_WIDTH * 72.0]

  def initialize(schedule)
    super()
    @schedule = schedule
    self.print_data
  end

  def print_data

    # Determine first and last shift.
    @schedule_start = nil
    @schedule_end = nil
    @schedule[:shift_counts].each do |shift_count|
      next if shift_count[:total] == 0
      @schedule_start = shift_count[:shift_start].to_datetime if @schedule_start.nil? || shift_count[:shift_start] < @schedule_start
      @schedule_end = shift_count[:shift_end].to_datetime if @schedule_end.nil? || shift_count[:shift_end] > @schedule_end
    end
    @schedule_hours = (@schedule_end.to_i - @schedule_start.to_i) / 1.hours
    @schedule_blocks = @schedule_hours / 2

    # Printing calculations.
    @block_area_width = (SchedulePdf::SCHEDULE_WIDTH - SchedulePdf::EMPLOYEE_NAME_WIDTH - SchedulePdf::TOTAL_HOURS_WIDTH - 0.5)
    @block_width = @block_area_width / @schedule_blocks

    # Count employees by group.
    count_platers = 0
    count_shipping = 0
    count_lab = 0
    count_maintenance = 0
    @schedule[:employees].each do |employee|
      count_platers += 1 if employee[:schedule] == "plating"
      count_shipping += 1 if employee[:schedule] == "shipping"
      count_lab += 1 if employee[:schedule] == "lab"
      count_maintenance += 1 if employee[:schedule] == "maintenance"
    end

    # Print data.
    self.print_page_header(count_platers)
    self.print_group_schedule(7.6, "plating")
    self.start_new_page
    self.print_page_header(count_shipping, count_lab, count_maintenance)
    group_y = 7.6
    self.print_group_schedule(group_y, "shipping")
    group_y -= (SchedulePdf::TOTAL_ROW_HEIGHT + count_shipping * SchedulePdf::EMPLOYEE_ROW_HEIGHT)
    self.print_group_schedule(group_y, "lab")
    group_y -= (SchedulePdf::TOTAL_ROW_HEIGHT + count_lab * SchedulePdf::EMPLOYEE_ROW_HEIGHT)
    self.print_group_schedule(group_y, "maintenance")
  end

  def print_page_header(rows, rows_2 = nil, rows_3 = nil)

    # Draw week ending title.
    self.txtb "Week Ending #{@schedule[:end_date].strftime "%m/%d/%Y"}",
              0.25,
              8.25,
              SchedulePdf::SCHEDULE_WIDTH - 0.5,
              0.25,
              h_align: :left,
              style: :bold,
              size: 14

    # Draw block headers and blocks.
    current_shift_start = @schedule_start
    shift_width = 6 * @block_width
    current_x = 0.25 + SchedulePdf::EMPLOYEE_NAME_WIDTH
    shade = true
    totals_box_y = 7.6 - SchedulePdf::BLOCK_TIME_HEIGHT - rows * SchedulePdf::EMPLOYEE_ROW_HEIGHT
    self.rect current_x,
              totals_box_y,
              SchedulePdf::SCHEDULE_WIDTH - current_x - 0.25,
              SchedulePdf::TOTAL_ROW_HEIGHT,
              fill_color: "151515",
              line_color: nil
    unless rows_2.nil?
      totals_box_y -= (SchedulePdf::TOTAL_ROW_HEIGHT + rows_2 * SchedulePdf::EMPLOYEE_ROW_HEIGHT)
      self.rect current_x,
                totals_box_y,
                SchedulePdf::SCHEDULE_WIDTH - current_x - 0.25,
                SchedulePdf::TOTAL_ROW_HEIGHT,
                fill_color: "151515",
                line_color: nil
    end
    unless rows_3.nil?
      totals_box_y -= (SchedulePdf::TOTAL_ROW_HEIGHT + rows_3 * SchedulePdf::EMPLOYEE_ROW_HEIGHT)
      self.rect current_x,
                totals_box_y,
                SchedulePdf::SCHEDULE_WIDTH - current_x - 0.25,
                SchedulePdf::TOTAL_ROW_HEIGHT,
                fill_color: "151515",
                line_color: nil
    end
    while current_shift_start < @schedule_end
      current_block_start = current_shift_start
      shift_number = current_shift_start.hour == 7 ? 1 : 2
      self.txtb "#{current_shift_start.strftime "%a"} #{shift_number}<sup>#{shift_number == 1 ? "st" : "nd"}</sup> Shift",
                current_x,
                7.75,
                shift_width,
                0.15,
                h_align: :left,
                style: :bold,
                size: 8
      shade_box_y = 7.6
      self.rect current_x,
                shade_box_y,
                shift_width,
                rows * SchedulePdf::EMPLOYEE_ROW_HEIGHT + SchedulePdf::BLOCK_TIME_HEIGHT,
                fill_color: (shade ? "cccccc" : "eeeeee"),
                line_color: nil
      unless rows_2.nil?
        shade_box_y -= (SchedulePdf::BLOCK_TIME_HEIGHT + rows * SchedulePdf::EMPLOYEE_ROW_HEIGHT + SchedulePdf::TOTAL_ROW_HEIGHT)
        self.rect current_x,
                  shade_box_y,
                  shift_width,
                  rows_2 * SchedulePdf::EMPLOYEE_ROW_HEIGHT,
                  fill_color: (shade ? "cccccc" : "eeeeee"),
                  line_color: nil
      end
      unless rows_3.nil?
        shade_box_y -= (rows_2 * SchedulePdf::EMPLOYEE_ROW_HEIGHT + SchedulePdf::TOTAL_ROW_HEIGHT)
        self.rect current_x,
                  shade_box_y,
                  shift_width,
                  rows_3 * SchedulePdf::EMPLOYEE_ROW_HEIGHT,
                  fill_color: (shade ? "cccccc" : "eeeeee"),
                  line_color: nil
      end
      while current_block_start < current_shift_start + 12.hours
        outline_height = SchedulePdf::BLOCK_TIME_HEIGHT + rows * SchedulePdf::EMPLOYEE_ROW_HEIGHT + SchedulePdf::TOTAL_ROW_HEIGHT
        unless rows_2.nil?
          outline_height += rows_2 * SchedulePdf::EMPLOYEE_ROW_HEIGHT + SchedulePdf::TOTAL_ROW_HEIGHT
        end
        unless rows_3.nil?
          outline_height += rows_3 * SchedulePdf::EMPLOYEE_ROW_HEIGHT + SchedulePdf::TOTAL_ROW_HEIGHT
        end
        self.rect current_x,
                  7.6,
                  @block_width,
                  outline_height,
                  line_width: 0.008
        self.txtb "#{current_block_start.strftime("%l %P").squish} - #{(current_block_start + 2.hours).strftime("%l %P").squish}",
                  current_x - (SchedulePdf::BLOCK_TIME_HEIGHT / 2) + (@block_width / 2),
                  7.6 - (SchedulePdf::BLOCK_TIME_HEIGHT / 2) + (@block_width / 2),
                  SchedulePdf::BLOCK_TIME_HEIGHT,
                  @block_width,
                  h_align: :center,
                  v_align: :center,
                  size: 6,
                  rotate: 90,
                  rotate_around: :center
        current_x += @block_width
        current_block_start += 2.hours
      end
      current_shift_start += 12.hours
      shade = !shade
    end
    self.rect current_x,
              7.6,
              SchedulePdf::TOTAL_HOURS_WIDTH,
              outline_height,
              line_width: 0.008
    self.txtb "Total Hours",
              current_x - (SchedulePdf::BLOCK_TIME_HEIGHT / 2) + (SchedulePdf::TOTAL_HOURS_WIDTH / 2),
              7.6 - (SchedulePdf::BLOCK_TIME_HEIGHT / 2) + (SchedulePdf::TOTAL_HOURS_WIDTH / 2),
              SchedulePdf::BLOCK_TIME_HEIGHT,
              SchedulePdf::TOTAL_HOURS_WIDTH,
              h_align: :center,
              v_align: :center,
              size: 6,
              rotate: 90,
              rotate_around: :center

  end

  def print_group_schedule(y, target_schedule)

    # Initialize coordinates.
    current_y = y - SchedulePdf::BLOCK_TIME_HEIGHT

    # Initialize total hours.
    grand_total_hours = 0

    # Draw employees.
    @schedule[:employee_order][target_schedule.to_sym].each do |target_employee|
      @schedule[:employees].each do |employee|
        next unless employee[:schedule] == target_schedule
        next unless employee[:employee][:number] == target_employee[:number]
        self.txtb "#{employee[:employee][:first][0]}. #{employee[:employee][:last]}",
                  0.25,
                  current_y,
                  SchedulePdf::SCHEDULE_WIDTH - 0.5,
                  SchedulePdf::EMPLOYEE_ROW_HEIGHT,
                  line_color: "000000",
                  line_width: 0.008,
                  h_align: :left,
                  size: 6,
                  h_pad: 0.1
        grand_total_hours += employee[:scheduled_hours]
        self.txtb self.format_number(employee[:scheduled_hours], decimals: 2),
                  SchedulePdf::SCHEDULE_WIDTH - 0.25 - SchedulePdf::TOTAL_HOURS_WIDTH,
                  current_y,
                  SchedulePdf::TOTAL_HOURS_WIDTH,
                  SchedulePdf::EMPLOYEE_ROW_HEIGHT,
                  size: 6,
                  h_pad: 0.1
        employee[:shifts].each do |shift|
          next if shift[:hours] == 0
          shift_start_time = shift[:start_time].to_datetime
          shift_end_time = shift[:end_time].to_datetime
          width_percentage = shift[:hours].to_f / @schedule_hours.to_f
          width = width_percentage * @block_area_width
          hours_to_start_of_shift = ((shift_start_time.to_i - @schedule_start.to_i)).to_f / 1.hours.to_f
          offset_percentage = hours_to_start_of_shift.to_f / @schedule_hours.to_f
          offset = offset_percentage * @block_area_width
          fill_color = case shift[:type]
                      when "supervisor"
                        "ffb81c"
                      when "training"
                        "00aeef"
                      else
                        "aadb1e"
                      end
          self.txtb "#{shift_start_time.strftime(shift_start_time.minute == 0 ? "%l" : "%l:%M").squish} - #{shift_end_time.strftime(shift_end_time.minute == 0 ? "%l" : "%l:%M").squish}",
                    0.25 + SchedulePdf::EMPLOYEE_NAME_WIDTH + offset + (SchedulePdf::SCHEDULE_BOX_HEIGHT_BUFFER / 2),
                    current_y - (SchedulePdf::SCHEDULE_BOX_HEIGHT_BUFFER / 2),
                    width - SchedulePdf::SCHEDULE_BOX_HEIGHT_BUFFER,
                    SchedulePdf::EMPLOYEE_ROW_HEIGHT - SchedulePdf::SCHEDULE_BOX_HEIGHT_BUFFER,
                    fill_color: fill_color,
                    size: 6,
                    style: :bold,
                    line_color: "000000",
                    line_width: 0.004
        end
        current_y -= SchedulePdf::EMPLOYEE_ROW_HEIGHT
      end
    end

    # Print totals row.
    self.txtb target_schedule.titleize,
              0.25,
              current_y,
              SchedulePdf::EMPLOYEE_NAME_WIDTH,
              SchedulePdf::TOTAL_ROW_HEIGHT,
              size: 9,
              style: :bold,
              h_pad: 0.1
    self.txtb self.format_number(grand_total_hours, decimals: 2),
              SchedulePdf::SCHEDULE_WIDTH - 0.25 - SchedulePdf::TOTAL_HOURS_WIDTH,
              current_y,
              SchedulePdf::TOTAL_HOURS_WIDTH,
              SchedulePdf::TOTAL_ROW_HEIGHT,
              size: 6,
              h_pad: 0.1,
              color: "ffffff"
    current_block_start = @schedule_start
    current_x = 0.25 + SchedulePdf::EMPLOYEE_NAME_WIDTH
    while current_block_start < @schedule_end
      count = 0
      @schedule[:headcounts].each do |headcount|
        count = headcount[target_schedule.to_sym] if headcount[:block_start].to_datetime == current_block_start
      end
      self.txtb self.format_number(count, decimals: 2),
                current_x - (SchedulePdf::TOTAL_ROW_HEIGHT / 2) + (@block_width / 2),
                current_y - (SchedulePdf::TOTAL_ROW_HEIGHT / 2) + (@block_width / 2),
                SchedulePdf::TOTAL_ROW_HEIGHT,
                @block_width,
                h_align: :center,
                v_align: :center,
                size: 6,
                rotate: 90,
                rotate_around: :center,
                color: "ffffff"
      current_x += @block_width
      current_block_start += 2.hours
    end

  end

end