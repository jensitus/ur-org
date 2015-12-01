json.array!(@photo_galleries) do |photo_gallery|
  json.extract! photo_gallery, :id, :title, :description
  json.url photo_gallery_url(photo_gallery, format: :json)
end
