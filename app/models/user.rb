class User < ApplicationRecord

  # Configure Devise for authentication.
  devise  :rememberable,
          :trackable,
          :timeoutable,
          :omniauthable, omniauth_providers: [:google_oauth2]

  # Soft deletes.
  include Discard::Model

  # Associations.
  has_one   :permission
  has_many  :reviews
  has_many  :notifications
  has_many  :comments
  has_many  :reject_tags,
            class_name: 'Quality::RejectTag'
  has_many  :authored_receiving_priority_notes,
            class_name: 'Shipping::ReceivingPriorityNote',
            foreign_key: "requested_by_user_id"
  has_many  :completed_receiving_priority_notes,
            class_name: 'Shipping::ReceivingPriorityNote',
            foreign_key: "completed_by_user_id"

  # Scopes.
  scope :by_number, -> { order(:employee_number) }
  scope :active, -> { where("is_active IS TRUE") }
  scope :clocked_in, -> { where.not(clocked_in_at: nil).by_number }
  scope :as_foreman, -> { clocked_in.where(is_foreman: true) }

  # Validations.
  validates :email, :name, :employee_number,
            presence: true
  validates :email, :employee_number,
            uniqueness: true
  validates :email,
            format: { with: /@varland.com\z/ }
  validates :employee_number,
            numericality: { only_integer: true, greater_than: 0 }

  # Callbacks.
  after_create_commit :create_permissions_if_not_exist

  # Instance methods.

  # Return foreman specific email address or fallback to standard email.
  def foreman_email
    return self.foreman_email_address if self.foreman_email_address.present?
    return self.email
  end

  # Shortcut method for converting object to string.
  def to_s
    return self.name_and_number
  end

  # Returns user name and number.
  def name_and_number
    "<code class=\"fw-700\">#{self.employee_number}</code> #{self.name}".html_safe
  end

  # Creates user permission record if does not exist.
  def create_permissions_if_not_exist
    return if self.permission.present?
    Permission.create(user_id: self.id)
  end

  # Updates user fields from System i.
  def update_fields_from_system_i
    json = User.system_i_json(self.email)
    return if json.blank? || !json[:valid]
    self.employee_number = json[:number]
    self.title = json[:title]
    self.username = json[:username]
    self.pin = json[:pin]
    self.save
  end

  # Class methods.

  # Method to create from Google authentication.
  def self.from_google(email:, name:, uid:)
    user = User.where(email: email).first
    if user.blank?
      system_i = self.system_i_json(email)
      return nil if system_i.blank? || !system_i[:valid]
      api_client = PayrollPartnersApiClient.new
      user_attributes = {
        uid: uid,
        name: name,
        employee_number: system_i[:number],
        title: system_i[:title],
        username: system_i[:username],
        pin: system_i[:pin],
        payroll_account_id: api_client.get_account_id(system_i[:number])
      }
      user = User.create(user_attributes)
    end
    return user
    #system_i = self.system_i_json(email)
    #return nil if system_i.blank? || !system_i[:valid]
    #user_attributes = {
    #  uid: uid,
    #  name: name,
    #  employee_number: system_i[:number],
    #  title: system_i[:title],
    #  username: system_i[:username],
    #  pin: system_i[:pin]
    #}
    #create_with(user_attributes).find_or_create_by!(email: email)
  end

  # Method to lookup user information from System i.
  def self.system_i_json(email)
    uri = URI.parse("http://vcmsapi.varland.com/employee?email=#{email}")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    return nil unless response.code.to_s == "200"
    return JSON.parse(response.body, symbolize_names: true)
  end

end