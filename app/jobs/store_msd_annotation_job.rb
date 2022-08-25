class StoreMSDAnnotationJob < ApplicationJob

  queue_as :default

  def perform(user, type)

    # Create body for request.
    data = {
      dashboardUID: "eeNBVwi4k",
      panelId: 2,
      time: Time.current.to_i * 1000,
      tags: ["MSD"]
    }
    case type
    when :eight_hour
      data[:tags] << "8 Hour"
      data[:text] = "8 hour verification that final pH is okay. (#{user})"
    when :calibration
      data[:tags] << "Calibration"
      data[:text] = "Weekly calibration of final pH meter. (#{user})"
    when :weekly
      data[:tags] << "Weekly"
      data[:text] = "Weekly verification of previous week. No final pH violations. (#{user})"
    else
      return
    end

    # Configure URL and options.
    url = URI.parse("http://historian.varland.com/api/annotations")
    http = Net::HTTP.new(url.host, url.port)

    # Configure request.
    request = Net::HTTP::Post.new(url)
    request["Authorization"] = Rails.application.credentials.grafana[:token]
    request["Content-Type"] = "application/json"
    request.body = data.to_json

    # Send request.
    response = http.request(request)

  end

end