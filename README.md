# Korgi

[![Gem Version](https://badge.fury.io/rb/korgi.svg)](https://badge.fury.io/rb/korgi)
[![Code Climate](https://codeclimate.com/github/jodeci/korgi/badges/gpa.svg)](https://codeclimate.com/github/jodeci/korgi)
[![Test Coverage](https://codeclimate.com/github/jodeci/korgi/badges/coverage.svg)](https://codeclimate.com/github/jodeci/korgi/coverage)
[![Build Status](https://travis-ci.org/jodeci/korgi.svg?branch=master)](https://travis-ci.org/jodeci/korgi)

[HTML::Pipeline](https://github.com/jch/html-pipeline) filters to generate urls for Rails resources with Markdown.

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
  config.file_uploads = { image: [Image, :file, :thumb] }
end
```

This tells *korgi* that you have a CarrierWave uploader mounted to `Image:file`, with `:thumb` as it's default version. You can then simply write `$+image.1$` or `$+image.1.large$` in your markdown input, and *korgi* will replace the syntax with the associated url (and version).

If you need the full url instead, you should change the settings for CarrierWave:

```
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
/admin/posts/1
```

You will need to tell *korgi* how to map resouces for you:

```
# config/initializers/korgi.rb
Korgi.configure do |config|
  config.named_routes = { post: "admin/posts" }
end
```

*korgi* will then be able to replace `$#post.1$` with the result of `admin_post_path(1)`.

### putting it all together

I tried to keep *korgi* simple, so you will still need to render the markdown syntax. Please do check out the documentation for [HTML::Pipeline](https://github.com/jch/html-pipeline). Here is an example snippet:

```
pipeline =
  HTML::Pipeline.new [
    Korgi::FileUploadFilter,
    Korgi::NamedRouteFilter,
    HTML::Pipeline::MarkdownFilter
  ]
result = pipeline.call <<-EOD
This is a [link to post1]($#post.1$).
EOD
result[:output].to_s

=>
<p>This is a <a href="/admin/posts/1">link to post1</a>.</p>
```

## Contributing
Send me a PR!

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
