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
  after_create  :create_permissions_if_not_exist

  # Instance methods.

  # Returns user name and number.
  def name_and_number
    "<code class=\"fw-700\">#{self.employee_number}</code> #{self.name}".html_safe
  end

  # Method to be run after user logs in.
  def after_login
    self.create_permissions_if_not_exist
    self.update_fields_from_system_i
  end

  # Creates user permission record if does not exist.
  def create_permissions_if_not_exist
    return if self.permission.present?
    Permission.create(user_id: self.id)
  end

  # Updates user fields from System i.
  def update_fields_from_system_i
    json = User.system_i_json(self.email)
    self.employee_number = json[:number]
    self.title = json[:title]
    self.username = json[:username]
    self.save
  end

  # Class methods.

  # Method to create from Google authentication.
  def self.from_google(email:, name:, uid:)
    system_i = self.system_i_json(email)
    return nil if system_i.blank? || !system_i[:valid]
    user_attributes = {
      uid: uid,
      name: name,
      employee_number: system_i[:number],
      title: system_i[:title],
      username: system_i[:username]
    }
    create_with(user_attributes).find_or_create_by!(email: email)
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