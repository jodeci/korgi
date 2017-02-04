Korgi.configure do |config|
  config.named_routes = { post: "admin/posts" }
  config.file_uploads = { image: [Image, :file, :thumb] }
end
