class PayrollPartnersApiClient

  # Define attribute accessors.
  attr_accessor :token

  # Constructor.
  def initialize

    # Get encrypted credentials.
    @credentials = Rails.application.credentials.payroll_partners

    # Initialize object properties.
    @token = nil

  end

  # Performs log in request to get bearer token for future requests.
  def login

    # Configure URL and options.
    url = URI.parse("https://secure.saashr.com/ta/rest/v1/login")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    # Configure request.
    request = Net::HTTP::Post.new(url)
    request["Accept"] = "application/json"
    request["Content-Type"] = "application/json"
    request["Api-Key"] = @credentials[:api_key]
    request.body = {
      credentials: {
        username: @credentials[:username],
        password: @credentials[:password],
        company: @credentials[:company_name]
      }
    }.to_json

    # Send request.
    response = http.request(request)
    if response.code.to_i == 200
      json = JSON.parse(response.body, symbolize_names: true)
      @token = json[:token]
      return true
    else
      @token = nil
      return false
    end

  rescue
    @token = nil
    return false
  end

  # Retrieves user account ID for given employee number.
  def get_account_id(employee_number)

    # Return employee number without lookup if number greater than 1000.
    return employee_number if employee_number > 1000
      
    # If not logged in, login.
    if @token.nil?
      if !self.login
        return nil
      end
    end

    # Configure URL and options.
    url = URI.parse("https://secure.saashr.com/ta/rest/v2/companies/#{@credentials[:company_id]}/employees")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    # Configure request.
    request = Net::HTTP::Get.new(url)
    request["Authentication"] = "Bearer #{@token}"

    # Send request.
    response = http.request(request)
    if response.code.to_i == 200
      json = JSON.parse(response.body, symbolize_names: true)
      json[:employees].each do |employee|
        return employee[:id] if employee[:employee_id].to_i == employee_number
      end
    end
    return nil

  rescue
    return nil
  end

  # Retrieves users clocked in right now.
  def clocked_in_now

    # If not logged in, login.
    if @token.nil?
      if !self.login
        return nil
      end
    end

    # Initialize array of employees.
    employees = {}

    # Configure URL and options.
    url = URI.parse("https://secure.saashr.com/ta/rest/v2/companies/#{@credentials[:company_id]}/attendance?status=IN")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    # Configure request.
    request = Net::HTTP::Get.new(url)
    request["Authentication"] = "Bearer #{@token}"

    # Send request.
    response = http.request(request)
    if response.code.to_i == 200
      json = JSON.parse(response.body, symbolize_names: true)
      json[:attendance].each do |employee|
        employees[employee[:employee][:account_id]] = DateTime.parse(employee[:last_start])
      end
      return employees
    else
      return nil
    end

  rescue
    return nil
  end

  # Retrieves user account IDs.
  def get_account_ids()
      
    # If not logged in, login.
    if @token.nil?
      if !self.login
        return nil
      end
    end

    # Configure URL and options.
    url = URI.parse("https://secure.saashr.com/ta/rest/v2/companies/#{@credentials[:company_id]}/employees")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    # Configure request.
    request = Net::HTTP::Get.new(url)
    request["Authentication"] = "Bearer #{@token}"

    # Send request.
    response = http.request(request)
    if response.code.to_i == 200
      employees = []
      json = JSON.parse(response.body, symbolize_names: true)
      json[:employees].each do |employee|
        employees << { number: employee[:employee_id].to_i, id: employee[:id] }
      end
      employees.sort_by! { |e| e[:number] }
      return employees
    end
    return nil

  rescue
    return nil
  end








  

  # # Performs request to get roster.
  # def get_roster

  #   # If not logged in, login.
  #   if @token.nil?
  #     if !self.login
  #       @employees = nil
  #       return @employees
  #     end
  #   end

  #   # Initialize array of employees.
  #   @employees = []

  #   # Configure URL and options.
  #   url = URI.parse("https://secure.saashr.com/ta/rest/v2/companies/#{@credentials[:company_id]}/employees")
  #   http = Net::HTTP.new(url.host, url.port)
  #   http.use_ssl = true
  #   http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  #   # Configure request.
  #   request = Net::HTTP::Get.new(url)
  #   request["Authentication"] = "Bearer #{@token}"

  #   # Send request.
  #   response = http.request(request)
  #   if response.code.to_i == 200
  #     json = JSON.parse(response.body, symbolize_names: true)
  #     json[:employees].each do |employee|
  #       next unless employee[:status] == "Active"
  #       @employees << self.get_employee_details(employee)
  #     end
  #   else
  #     return nil
  #   end
  #   @employees.sort_by! { |e| e[:number] }
  #   return @employees

  # rescue
  #   return nil
  # end

  # # Performs request to get roster with clock status.
  # def get_roster_with_clock_status

  #   # If not logged in, login.
  #   if @token.nil?
  #     if !self.login
  #       @employees = nil
  #       return nil
  #     end
  #   end

  #   # Get roster.
  #   self.get_roster

  #   # Initialize clock status for all employees.
  #   @employees.each do |employee|
  #     employee[:in_at] = :nil
  #   end

  #   # Configure URL and options.
  #   url = URI.parse("https://secure.saashr.com/ta/rest/v2/companies/#{@credentials[:company_id]}/attendance?status=IN")
  #   http = Net::HTTP.new(url.host, url.port)
  #   http.use_ssl = true
  #   http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  #   # Configure request.
  #   request = Net::HTTP::Get.new(url)
  #   request["Authentication"] = "Bearer #{@token}"

  #   # Send request.
  #   response = http.request(request)
  #   if response.code.to_i == 200
  #     json = JSON.parse(response.body, symbolize_names: true)
  #     #puts json[:attendance]
  #     json[:attendance].each do |employee|
  #       @employees.each do |emp|
  #         if emp[:id] == employee[:employee][:account_id]
  #           emp[:in_at] = DateTime.parse(employee[:last_start])
  #         end
  #       end
  #     end
  #   end

  #   # Return employees.
  #   return @employees

  # end

  # # Performs request to get individual employee details.
  # def get_employee_details(employee)

  #   # Initialize employee object.
  #   emp = {
  #     id: employee[:id],
  #     username: employee[:username],
  #     number: employee[:employee_id].to_i,
  #     first: employee[:first_name],
  #     last: employee[:last_name]
  #   }
  #   return emp

  #   # Configure URL and options.
  #   url = URI.parse("https://secure.saashr.com/ta/rest/v2/companies/#{@credentials[:company_id]}/employees/#{employee[:id]}")
  #   http = Net::HTTP.new(url.host, url.port)
  #   http.use_ssl = true
  #   http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  #   # Configure request.
  #   request = Net::HTTP::Get.new(url)
  #   request["Authentication"] = "Bearer #{@token}"

  #   # Send request.
  #   response = http.request(request)
  #   if response.code.to_i == 200
  #     json = JSON.parse(response.body, symbolize_names: true)
  #     emp[:email] = json[:primary_email]
  #     return emp
  #   else
  #     return nil
  #   end

  # rescue
  #   return nil
  # end

  # # Performs request to get employee numbers for account IDs.
  # def get_employee_numbers

  #   # If not logged in, login.
  #   if @token.nil?
  #     if !self.login
  #       @employee_numbers = nil
  #       return @employee_numbers
  #     end
  #   end

  #   # Initialize array of employees.
  #   @employee_numbers = []

  #   # Configure URL and options.
  #   url = URI.parse("https://secure.saashr.com/ta/rest/v2/companies/#{@credentials[:company_id]}/employees")
  #   http = Net::HTTP.new(url.host, url.port)
  #   http.use_ssl = true
  #   http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  #   # Configure request.
  #   request = Net::HTTP::Get.new(url)
  #   request["Authentication"] = "Bearer #{@token}"

  #   # Send request.
  #   response = http.request(request)
  #   if response.code.to_i == 200
  #     json = JSON.parse(response.body, symbolize_names: true)
  #     json[:employees].each do |employee|
  #       next unless employee[:status] == "Active"
  #       @employee_numbers << {
  #         id: employee[:id],
  #         username: employee[:username],
  #         number: employee[:employee_id].to_i,
  #         first: employee[:first_name],
  #         last: employee[:last_name]
  #       }
  #     end
  #   else
  #     @employee_numbers = nil
  #   end
  #   @employee_numbers.sort_by! { |e| e[:number] }
  #   return @employee_numbers

  # rescue
  #   @employee_numbers = nil
  #   return @employee_numbers
  # end

  # # # Performs request to get currently logged in users.
  # # def get_employees_in_now

  # #   # If not logged in, login.
  # #   if @token.nil?
  # #     if !self.login
  # #       return nil
  # #     end
  # #   end

  # #   # If not retrieved, retrieve employee numbers.
  # #   if @employee_numbers.nil?
  # #     self.get_employee_numbers
  # #     if @employee_numbers.nil?
  # #       return nil
  # #     end
  # #   end

  # #   # Initialize array of employees.
  # #   employees = []

  # #   # Configure URL and options.
  # #   url = URI.parse("https://secure.saashr.com/ta/rest/v2/companies/#{@credentials[:company_id]}/attendance?status=IN")
  # #   http = Net::HTTP.new(url.host, url.port)
  # #   http.use_ssl = true
  # #   http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  # #   # Configure request.
  # #   request = Net::HTTP::Get.new(url)
  # #   request["Authentication"] = "Bearer #{@token}"

  # #   # Send request.
  # #   response = http.request(request)
  # #   if response.code.to_i == 200
  # #     json = JSON.parse(response.body, symbolize_names: true)
  # #     json[:attendance].each do |employee|
  # #       number = nil
  # #       @employee_numbers.each do |e|
  # #         number = e[:number] if e[:id] == employee[:employee][:account_id]
  # #       end
  # #       employees << {
  # #         name: employee[:employee][:display_name],
  # #         number: number,
  # #         in_at: DateTime.parse(employee[:last_start])
  # #       }
  # #     end
  # #     employees.sort_by! { |e| e[:number] }
  # #     clocked_in = {
  # #       platers: [],
  # #       maintenance: [],
  # #       lab: [],
  # #       shipping: [],
  # #       supervisors: [],
  # #       office: []
  # #     }
  # #     employees.each do |employee|
  # #       case employee[:number]
  # #       when 0...200
  # #         clocked_in[:platers] << employee
  # #       when 200...300
  # #         clocked_in[:maintenance] << employee
  # #       when 300...400
  # #         clocked_in[:lab] << employee
  # #       when 400...500
  # #         clocked_in[:shipping] << employee
  # #       when 600...700
  # #         clocked_in[:supervisors] << employee
  # #       when 800...900
  # #         clocked_in[:office] << employee
  # #       end
  # #     end
  # #     return clocked_in
  # #   else
  # #     return nil
  # #   end

  # # rescue
  # #   return nil
  # # end

  # # Performs request to get employee schedules.
  # def get_schedule(start_date = nil)

  #   # If not logged in, login.
  #   if @token.nil?
  #     if !self.login
  #       return nil
  #     end
  #   end

  #   # If not retrieved, retrieve employee numbers.
  #   if @employee_numbers.nil?
  #     self.get_employee_numbers
  #     if @employee_numbers.nil?
  #       return nil
  #     end
  #   end

  #   # Format starting and ending dates.
  #   if start_date.nil?
  #     start_date = Date.current.next_occurring(:sunday)
  #   end
  #   end_date = start_date.next_occurring(:saturday)

  #   # Initialize array of schedules.
  #   employee_schedules = []

  #   # Retrieve schedule for each employee.
  #   @employee_numbers.each do |employee|

  #     # Skip unless desired user.
  #     next if (700...1000).include?(employee[:number])

  #     # Determine schedule for employee.
  #     employee_schedule = case employee[:number]
  #                         when 0...200, 628, 636, 639
  #                           "plating"
  #                         when 200...300 #, 622, 632, 637
  #                           "maintenance"
  #                         when 300...400
  #                           "lab"
  #                         when 400...500, 603, 629, 638
  #                           "shipping"
  #                         else
  #                           "other"
  #                         end

  #     # Configure URL and options.
  #     url = URI.parse("https://secure.saashr.com/ta/rest/v2/companies/#{@credentials[:company_id]}/employee/schedules?fromDate=#{start_date.strftime "%Y-%m-%d"}&toDate=#{end_date.strftime "%Y-%m-%d"}&username=#{employee[:username].downcase}")
  #     http = Net::HTTP.new(url.host, url.port)
  #     http.use_ssl = true
  #     http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  #     # Configure request.
  #     request = Net::HTTP::Get.new(url)
  #     request["Authentication"] = "Bearer #{@token}"

  #     # Send request for employee schedules.
  #     response = http.request(request)
  #     if response.code.to_i == 200
  #       json = JSON.parse(response.body, symbolize_names: true)
  #       employee_shifts = self.extract_shifts(employee, json[:schedules])
  #       employee_schedules << {
  #         employee: employee,
  #         schedule: employee_schedule,
  #         scheduled_hours: employee_shifts.map { |s| s[:hours] }.reduce(0,:+),
  #         shift_hours: {
  #           first: 0,
  #           second: 0,
  #           third: 0
  #         },
  #         primary_shift: nil,
  #         shifts: employee_shifts
  #       }
  #     end

  #   end

  #   # Initialize schedule object.
  #   schedule = {
  #     start_date: start_date,
  #     end_date: end_date,
  #     employees: employee_schedules,
  #     headcounts: [],
  #     shift_counts: []
  #   }

  #   # Calculate headcounts.
  #   block_start = "#{start_date.strftime "%Y-%m-%d"} 07:00:00".in_time_zone('Eastern Time (US & Canada)')
  #   week_end_timestamp = "#{(start_date + 1.week).strftime "%Y-%m-%d"} 07:00:00".in_time_zone('Eastern Time (US & Canada)')
  #   while block_start < week_end_timestamp
  #     headcount = {
  #       block_start: block_start,
  #       block_end: (block_start + 2.hours),
  #       plating: 0,
  #       maintenance: 0,
  #       lab: 0,
  #       shipping: 0
  #     }
  #     employee_schedules.each do |employee_schedule|
  #       next unless ["plating", "maintenance", "lab", "shipping"].include?(employee_schedule[:schedule])
  #       employee_schedule[:shifts].each do |shift|
  #         next unless ["normal", "flex"].include?(shift[:type])
  #         if shift[:start_time] < headcount[:block_end] && shift[:end_time] > headcount[:block_start]
  #           shift_block_start = [shift[:start_time], headcount[:block_start]].max
  #           shift_block_end = [shift[:end_time], headcount[:block_end]].min
  #           hours_in_block = (shift_block_end - shift_block_start) / 1.hour
  #           headcount[employee_schedule[:schedule].to_sym] += (hours_in_block.to_f / 2.0)
  #         end
  #       end
  #     end
  #     schedule[:headcounts] << headcount
  #     block_start += 2.hours
  #   end

  #   # Calculate shift counts.
  #   shift_start = "#{start_date.strftime "%Y-%m-%d"} 07:00:00".in_time_zone('Eastern Time (US & Canada)')
  #   while shift_start < week_end_timestamp
  #     headcount = {
  #       shift_start: shift_start,
  #       shift_end: (shift_start + 12.hours),
  #       plating: 0,
  #       maintenance: 0,
  #       lab: 0,
  #       shipping: 0
  #     }
  #     employee_schedules.each do |employee_schedule|
  #       next unless ["plating", "maintenance", "lab", "shipping"].include?(employee_schedule[:schedule])
  #       employee_schedule[:shifts].each do |shift|
  #         if shift[:start_time] < headcount[:shift_end] && shift[:end_time] > headcount[:shift_start]
  #           shift_block_start = [shift[:start_time], headcount[:shift_start]].max
  #           shift_block_end = [shift[:end_time], headcount[:shift_end]].min
  #           hours_in_block = (shift_block_end - shift_block_start) / 1.hour
  #           headcount[employee_schedule[:schedule].to_sym] += (hours_in_block.to_f / 12.0)
  #         end
  #       end
  #     end
  #     headcount[:total] = headcount[:plating] + headcount[:maintenance] + headcount[:lab] + headcount[:shipping]
  #     schedule[:shift_counts] << headcount
  #     shift_start += 12.hours
  #   end

  #   # Calculate employee shifts.
  #   employee_shift_start = "#{start_date.strftime "%Y-%m-%d"} 07:00:00".in_time_zone('Eastern Time (US & Canada)')
  #   week_end_timestamp = "#{(start_date + 1.week).strftime "%Y-%m-%d"} 07:00:00".in_time_zone('Eastern Time (US & Canada)')
  #   current_shift = :first
  #   while employee_shift_start < week_end_timestamp
  #     current_shift = case employee_shift_start.hour
  #                     when 7
  #                       :first
  #                     when 15
  #                       :second
  #                     when 23
  #                       :third
  #                     end
  #     employee_shift_end = employee_shift_start + 8.hours
  #     schedule[:employees].each do |employee|
  #       next unless ["plating", "maintenance", "lab", "shipping"].include?(employee[:schedule])
  #       employee[:shifts].each do |shift|
  #         if shift[:start_time].to_datetime < employee_shift_end && shift[:end_time].to_datetime > employee_shift_start
  #           this_shift_start = [shift[:start_time].to_datetime, employee_shift_start].max
  #           this_shift_end = [shift[:end_time].to_datetime, employee_shift_end].min
  #           hours_in_shift = (this_shift_end.to_i - this_shift_start.to_i).to_f / 1.hour.to_f
  #           employee[:shift_hours][current_shift] += hours_in_shift
  #         end
  #       end
  #     end
  #     employee_shift_start += 8.hours
  #   end
  #   schedule[:employee_order] = {
  #     plating: [],
  #     maintenance: [],
  #     lab: [],
  #     shipping: []
  #   }
  #   schedule[:employees].each do |employee|
  #     max_shift_hours = [employee[:shift_hours][:first], employee[:shift_hours][:second], employee[:shift_hours][:third]].max
  #     employee[:primary_shift] = 3 if employee[:shift_hours][:third] == max_shift_hours
  #     employee[:primary_shift] = 2 if employee[:shift_hours][:second] == max_shift_hours
  #     employee[:primary_shift] = 1 if employee[:shift_hours][:first] == max_shift_hours
  #     next unless ["plating", "maintenance", "lab", "shipping"].include?(employee[:schedule])
  #     shift_offset = employee[:employee][:number] < 600 ? 0 : 10
  #     #if employee[:employee][:number] < 600
  #       schedule[:employee_order][employee[:schedule].to_sym] << {
  #         number: employee[:employee][:number],
  #         shift: employee[:primary_shift] + shift_offset
  #       }
  #     #end
  #   end
  #   [:plating, :maintenance, :lab, :shipping].each do |group|
  #     schedule[:employee_order][group].sort_by! { |e| [e[:shift], e[:number]] }
  #   end

  #   # Return schedule object.
  #   return schedule

  # end

  # # Extracts shifts from schedule.
  # def extract_shifts(employee, schedules)
  #   shifts = []
  #   schedules.each do |schedule|
  #     case schedule[:type_name]
  #     when "Free Flow"
  #       shift_date = Date.parse(schedule[:date])
  #       start_time = "#{shift_date.strftime "%Y-%m-%d"} 09:00:00".in_time_zone('Eastern Time (US & Canada)')
  #       length = schedule[:total_hours].split(":")
  #       shift_hours = length[0].to_i
  #       shift_minutes = length[1].to_i
  #       shifts << {
  #         start_time: start_time,
  #         end_time: start_time + shift_hours.hours + shift_minutes.minutes,
  #         type: "flex"
  #       }
  #     when "Fixed"
  #       shift_start_date = Date.parse(schedule[:date])
  #       shift_end_date = (schedule[:end_time].include?("next")) ? (shift_start_date + 1.day) : shift_start_date
  #       start_time_string = "#{shift_start_date.strftime "%Y-%m-%d"} #{schedule[:start_time]}:00"
  #       end_time_string = "#{shift_end_date.strftime "%Y-%m-%d"} #{schedule[:end_time].sub(" next", "")}:00"
  #       type = "normal"
  #       type = "training" if schedule[:shift_premium] && schedule[:shift_premium] == "Training"
  #       type = "supervisor" if employee[:number] >= 600
  #       shifts << {
  #         start_time: start_time_string.in_time_zone('Eastern Time (US & Canada)'),
  #         end_time: end_time_string.in_time_zone('Eastern Time (US & Canada)'),
  #         type: type
  #       }
  #     end
  #   end
  #   shifts.each do |shift|
  #     shift[:hours] = (shift[:end_time] - shift[:start_time]) / 1.hour
  #   end
  #   return shifts
  # end

end