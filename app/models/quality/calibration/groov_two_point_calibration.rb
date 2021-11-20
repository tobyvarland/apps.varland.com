class Quality::Calibration::GroovTwoPointCalibration < Quality::Calibration::Calibration

  # Validations.
  validates :two_point_low_value,
            :two_point_low_reading,
            :two_point_high_value,
            :two_point_high_reading,
            :two_point_offset,
            :two_point_gain,
            presence: true
  validates :two_point_low_value,
            :two_point_low_reading,
            :two_point_high_value,
            :two_point_high_reading,
            :two_point_gain,
            numericality: { greater_than: 0 }
  validates :two_point_offset,
            numericality: true

end