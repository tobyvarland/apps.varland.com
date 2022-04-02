  class Groov::ChartRuntimeError < Groov::Log

    # Instance methods.

    # Log details.
    def details
      return self.format_log_data("Chart runtime error.", {
        chart: self.device,
        runtime: self.humanize_seconds(self.reading, 3),
        limit: self.humanize_seconds(self.limit, 3)
      })
    end

  end