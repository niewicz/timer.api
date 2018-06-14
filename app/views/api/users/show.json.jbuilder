if current_user.present?
  json.data do
    json.(current_user, 
      :id, 
      :uid, 
      :provider, 
      :email, 
      :first_name, 
      :last_name,
      :timezone)

    json.billing_profile do
      json.partial! 'api/users/billing_profile', user: current_user
    end
  end
else
  json.data json.nil!
end