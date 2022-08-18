class NetworkHost < ApplicationRecord

  # Enumerations.
  enum vlan_number: {
    management: 1,
    server: 2,
    pc: 3,
    printer: 4,
    corrotec: 5,
    opto: 6,
    modbus: 7,
    other: 8,
    voice: 9,
    video: 10
  }, _prefix: true

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

  # Scopes.
  scope :by_vlan_and_address, -> { order(:vlan_number, :address) }

  # Validations.
  validates :hostname, :vlan_number, :address, :mac_address, :location,
            presence: true
  validates :hostname, :mac_address,
            uniqueness: true
  validates :address,
            uniqueness: { scope: :vlan_number },
            numericality: { only_integer: true, greater_than: 1, less_than: 251 }
  validates :mac_address,
            format: { with: /\A[a-f\d]{2}(:[a-f\d]{2}){5}\z/i }
  validates :hostname,
            format: { with: /\A[a-z]([\-]?[a-z\d]+)*\z/ }
  validates :location,
            format: { with: /\AL\d\-[A-J]\-\d\z/i }

  # Instance methods.

  # Returns full IP address.
  def ip_address
    return "192.168.#{NetworkHost.vlan_numbers[self.vlan_number]}.#{"%03d" % self.address}"
  end

  # Returns FQDN.
  def fqdn
    return "#{self.hostname}.varland.com"
  end

end