json.extract! profile, :id, :email, :password_digest, :address1, :address2, :city, :state, :zip, :created_at, :updated_at
json.url profile_url(profile, format: :json)