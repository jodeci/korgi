# Korgi

[![Gem Version](https://badge.fury.io/rb/korgi.svg)](https://badge.fury.io/rb/korgi)
[![Code Climate](https://codeclimate.com/github/jodeci/korgi/badges/gpa.svg)](https://codeclimate.com/github/jodeci/korgi)
[![Test Coverage](https://codeclimate.com/github/jodeci/korgi/badges/coverage.svg)](https://codeclimate.com/github/jodeci/korgi/coverage)
[![Build Status](https://travis-ci.org/jodeci/korgi.svg?branch=master)](https://travis-ci.org/jodeci/korgi)

[html-pipeline](https://github.com/jch/html-pipeline) filters to generate urls for Rails resources.

## Usage

### Korgi::FileUploadFilter

```
# input
$+image.1$

# filtered result
/uploads/image/file/1/thumb_pic.jpg
```

*korgi* is meant to work with [CarrierWave](https://github.com/carrierwaveuploader/carrierwave). You will need to tell *korgi* how to map resources for you:

```
# config/initializers/korgi.rb
Korgi.configure do |config|
  config.file_uploads = { image: { model: :Image, mount: :file, default_version: :thumb }
end
```

This tells *korgi* that you have a CarrierWave uploader mounted to `Image` on `:file`, with `:thumb` as its default version. You can then simply write `$+image.1$` or `$+image.1.large$` in your markdown input, and *korgi* will replace the syntax with the associated url (and version).

If you are using a [Null Object Pattern](https://robots.thoughtbot.com/rails-refactoring-example-introduce-null-object), you can also set an optional `nil_object` for unavailable files to fallback for:

```
image: { ..., nil_object: :NullImage }
```

If you need the full url instead, you should change the settings for CarrierWave:

```
# config/initializers/carrierwave.rb
CarrierWave.configure do |config|
  config.asset_host = "http://awesome.host.com"
end

# filtered result
http://awesome.host.com/uploads/image/file/1/thumb_pic.jpg
```

### Korgi::NamedRouteFilter

```
# input
$#post.1$

# filtered result
/posts/1
```

You will need to tell *korgi* how to map resouces for you:

```
# config/initializers/korgi.rb
Korgi.configure do |config|
  config.named_routes = { post: { controller: :posts } }
end
```

In Rails speak, this means that *korgi* will replace  `$#post.1$` with the result of `post_path(id: 1)`. If you are using [FriendlyId](https://github.com/norman/friendly_id) to create url slugs, you can also do this:

```
# config/initializers/korgi.rb
Korgi.configure do |config|
  config.named_routes = { post: { controller: :posts, model: :Post, primary_key: :slug } }
end
```

This will enable *korgi* to interpret `$#post.1$` as `post_path(id: Post.find(1).slug)` instead, and will then return the slugged url, e,g, `/posts/slug-url`.

### putting it all together

I tried to keep *korgi* simple, so it only generates the link, not the entire html. You will most likely be using *korgi* along Markdown, but I'll leave that decision to you. Please do check out the documentation for [html-pipeline](https://github.com/jch/html-pipeline) on how to render Markdown content. Here is an example snippet:

```
pipeline =
  HTML::Pipeline.new [
    Korgi::FileUploadFilter,
    Korgi::NamedRouteFilter,
    HTML::Pipeline::MarkdownFilter
  ]
result = pipeline.call <<-EOD
This is a [link to post1]($#post.1$).
Here is an [image]($+image.1$).
EOD
result[:output].to_s

=>
<p>This is a <a href="/posts/1">link to post1</a>.</p>
<p>Here is an <img src="/uploads/image/file/1/thumb_pic.jpg" alt="image">.</p>
```

## Contributing
Send me a PR!

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
