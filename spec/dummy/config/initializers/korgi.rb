Korgi.configure do |config|
  config.named_routes = { post: ["posts", Post, :slug], apost: ["admin/posts", Post] }
  config.file_uploads = { image: [Image, :file, :thumb] }
end
