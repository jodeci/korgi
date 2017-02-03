Korgi.configure do |config|
  config.routes = { post: "admin/posts" }
  config.images = { image: [Image, :file, :thumb] }
end
