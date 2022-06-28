class NetworkHost < ApplicationRecord

  # Enumerations.
  enum vlan_number: {
    management: 1,
    server: 10,
    pc: 20,
    printer: 30,
    corrotec: 40,
    opto: 50,
    modbus: 60,
    other: 70,
    voice: 80,
    video: 90
  }, _prefix: true

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

  # Scopes.
  #scope :by_number, -> { order(:employee_number) }
  #scope :active, -> { where("is_active IS TRUE") }

  # Validations.
  validates :hostname, :vlan_number, :address, :mac_address,
            presence: true
  validates :hostname, :mac_address,
            uniqueness: true
  validates :address,
            uniqueness: { scope: :vlan_number },
            numericality: { only_integer: true, greater_than: 1, less_than: 255 }
  validates :mac_address,
            format: { with: /\A[a-f\d]{2}(:[a-f\d]{2}){5}\z/i }
  validates :hostname,
            format: { with: /\A[a-z\d]+\z/ }

  # Instance methods.

  # Returns full IP address.
  def ip_address
    return "192.168.#{NetworkHost.vlan_numbers[self.vlan_number]}.#{self.address}"
  end

  # Returns FQDN.
  def fqdn
    return "#{self.hostname}.vp.local"
  end

end