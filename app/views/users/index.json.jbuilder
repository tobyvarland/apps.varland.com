json.array! @users do |user|
	json.employee_number user.employee_number
	json.pin user.pin
end