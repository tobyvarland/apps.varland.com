json.array! @users do |user|
	json.employee_number user.employee_number
	json.name user.name
	json.pin user.pin
end