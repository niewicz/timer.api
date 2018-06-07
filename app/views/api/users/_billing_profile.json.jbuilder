if user.present? && user.billing_profile.present?
  billing_profile = user.billing_profile

  json.email billing_profile.email
  json.person_name billing_profile.person_name
  json.company_name billing_profile.company_name
  json.phone billing_profile.phone
  json.address billing_profile.address
  json.city billing_profile.city
  json.postal_code billing_profile.postal_code
  json.country billing_profile.country
  json.account_owner billing_profile.account_owner
  json.iban billing_profile.iban
  json.swift_code billing_profile.swift_code
  json.currency billing_profile.currency
else
  json.nil!
end