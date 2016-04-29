json.array!(@groups) do |group|
  json.extract! group, :id, :user_id, :gid, :name, :creator, :description, :privacy, :website, :email, :icon50, :icon
  json.url group_url(group, format: :json)
end
