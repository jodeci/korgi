Korgi.configure do |config|
  config.named_routes = { post: { controller: :posts, model: Post, primary_key: :slug }, apost: { controller: "admin/posts" } }
  config.file_uploads = { image: { model: Image, mount: :file, default_version: :thumb, nil_object: NullImage } }
end
