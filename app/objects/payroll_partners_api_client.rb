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

  # Performs request to get employee numbers for account IDs.
  def get_employee_numbers

    # If not logged in, login.
    if @token.nil?
      if !self.login
        @employee_numbers = nil
        return @employee_numbers
      end
    end

    # Initialize array of employees.
    @employee_numbers = []

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
        @employee_numbers << {
          id: employee[:id],
          number: employee[:employee_id].to_i
        }
      end
      return @employee_numbers
    else
      @employee_numbers = nil
    end
    return @employee_numbers

  rescue
    @employee_numbers = nil
    return @employee_numbers
  end

  # Performs request to get currently logged in users.
  def get_employees_in_now

    # If not logged in, login.
    if @token.nil?
      if !self.login
        return nil
      end
    end

    # If not retrieved, retrieve employee numbers.
    if @employee_numbers.nil?
      self.get_employee_numbers
      if @employee_numbers.nil?
        return nil
      end
    end

    # Initialize array of employees.
    employees = []

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
        number = nil
        @employee_numbers.each do |e|
          number = e[:number] if e[:id] == employee[:employee][:account_id]
        end
        employees << {
          name: employee[:employee][:display_name],
          number: number,
          in_at: DateTime.parse(employee[:last_start])
        }
      end
      employees.sort_by! { |e| e[:number] }
      clocked_in = {
        platers: [],
        maintenance: [],
        lab: [],
        shipping: [],
        supervisors: [],
        office: []
      }
      employees.each do |employee|
        case employee[:number]
        when 0...200
          clocked_in[:platers] << employee
        when 200...300
          clocked_in[:maintenance] << employee
        when 300...400
          clocked_in[:lab] << employee
        when 400...500
          clocked_in[:shipping] << employee
        when 600...700
          clocked_in[:supervisors] << employee
        when 800...900
          clocked_in[:office] << employee
        end
      end
      return clocked_in
    else
      return nil
    end

  rescue
    return nil
  end

end