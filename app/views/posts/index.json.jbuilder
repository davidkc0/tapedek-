json.array!(@posts) do |post|
  json.extract! post, :id, :title, :video_url
  json.url post_url(post, format: :json)
end
