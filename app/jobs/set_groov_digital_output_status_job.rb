class SetGroovDigitalOutputStatusJob < ApplicationJob

  queue_as :default

  def perform(args = {})

    # Parse passed arguments.
    io = args.fetch(:io, "local")
    mod = args.fetch(:module, nil)
    channel = args.fetch(:channel, nil)
    state = args.fetch(:state, nil)
    groov = args.fetch(:groov, nil)

    # Return if parameters not valid.
    return if mod.nil? || channel.nil? || groov.nil? || state.nil?

    # Configure URL and options.
    url = URI.parse("https://#{Rails.application.credentials.groov[groov][:url]}/manage/api/v1/io/#{io}/modules/#{mod}/channels/#{channel}/digital/state")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    # Configure request.
    request = Net::HTTP::Put.new(url)
    request["apiKey"] = Rails.application.credentials.groov[groov][:key]
    request["Content-Type"] = "application/json"
    request.body = "{ \"value\": #{state ? "true" : "false"} }"

    # Send request.
    response = http.request(request)

  end

end