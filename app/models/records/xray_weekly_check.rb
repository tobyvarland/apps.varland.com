class Records::XrayWeeklyCheck < Records::Result

  # Validations.
	validates	:fwhm_number,
            presence: true
  validates	:fwhm_number,
            numericality: { greater_than: 0 }

  # Class methods.

  # Define x-ray calibration names.
  def self.calibration_names
    return [
      "Zn-Ni/Fe",
      "Sn-Zn/Fe",
      "Sn/Cu",
      "High Cu",
      "Ni/Cu/Fe .5.1",
      "Ni/Cu/Fe .4.4",
      "Ni/Br",
      "Cu/Fe",
      "Zn/Fe",
      "Cd/Fe",
      "Ni/Fe",
      "Sn/Fe,Cu,Br",
      "Ni/Cu",
      "Mid-Phos EN"
    ]
  end

end