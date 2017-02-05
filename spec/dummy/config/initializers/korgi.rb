Korgi.configure do |config|
  config.named_routes = { post: [:posts, Post, :slug], apost: ["admin/posts"] }
  config.file_uploads = { image: [Image, :file, :thumb] }
end
