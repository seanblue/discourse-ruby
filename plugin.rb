# frozen_string_literal: true

# name: discourse-ruby
# about: Adds markdown.it ruby support to Discourse
# version: 1.0
# authors: seanblue
# url: https://github.com/seanblue/discourse-ruby

enabled_site_setting :enable_markdown_ruby

register_asset "javascripts/vendor/markdown-it-ruby.js", :vendored_pretty_text
