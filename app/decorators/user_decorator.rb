class UserDecorator < Draper::Decorator

  delegate_all

  def name_and_number
    "<code class=\"fw-700\">#{object.employee_number}</code> #{object.name}".html_safe
  end

end
