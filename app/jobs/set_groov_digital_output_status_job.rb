class SetGroovDigitalOutputStatusJob < ApplicationJob

  queue_as :default

  def perform(args = {})

    # Parse passed arguments.
    state = args.fetch(:state, nil)
    groov = args.fetch(:groov, nil)
    name = args.fetch(:name, nil)

    # Return if parameters not valid.
    return if name.nil? || groov.nil? || state.nil?

    # Configure URL and options.
    url = URI.parse("https://#{Rails.application.credentials.groov[groov][:url]}/pac/device/strategy/ios/digitalOutputs/#{name}/state") #manage/api/v1/io/#{io}/modules/#{mod}/channels/#{channel}/digital/state")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    # Configure request.
    request = Net::HTTP::Post.new(url)
    request["apiKey"] = Rails.application.credentials.groov[groov][:key]
    request["Content-Type"] = "application/json"
    request.body = "{ \"value\": #{state ? "true" : "false"} }"

    # Send request.
    response = http.request(request)

  end

end