# Blogly
Cute lil' blogging software for nerds.
(Currently version 0.1; future features are marked appropriately)

## Features
- Database-free, markdown file publishing: write articles with your favorite text editor & store in source control
  - Preprocessing to allow for special effects like hiddenness (0.3), summaries (0.3), and more
  - Code syntax highlighting (0.35)
- Full set of overridable, customizable templates
  - Simple HTML5 markup
  - Social plugins (Facebook like)
  - Commenting plugins (Facebook, discus coming in 0.5)
- Multi-device overridable stylesheets
  - Basic layouts using the Less Framework for cross-platform readability (including mobile, all in 0.4)
  - A variety of built-in themes (in 0.6)
- RSS feedage (in 0.2)

## Setup
Blogly is a essentially mixin with templates; all it requires is a basic sinatra app and the line `include Blogly::Base`.

The minimum necessary setup with config.ru (so you can use pow or passenger):

    # config.ru
    require 'bundler'
    require 'sinatra'
    Bundler.require

    require "#{File.dirname(__FILE__)}/app"
    run App

    # app.rb
    class App < Sinatra::Base
      include Blogly
      
      def self.blogly_settings
        { :title => "My Hot New Blog" }
      end
    end


## Customization
There are a few ways in which you can customize Blogly:

- Create or override mappings for totally custom behavior
- Override templates individually. The Blogly gem has a set of basic blogging templates which it uses by default; you can override any of these by placing it in your views folder (./views unless you set a different Sinatra views path). The default templates are as follows:
  - *layout.haml*: Main site layout
  - *_header.haml*: Layout header
  - *_footer.haml*: Layout footer
  - *index.haml*: Home page, renders a list of the most recent dated articles and a nav of undated articles (a.k.a. pages) (0.3)
  - *show.haml*: Article page, renders a single article with comments (if enabled)
  - *_article.haml*: Single article content
  - *app.scss*: Basic layout styling
  - *themes.scss*: Theme styling (0.6)
- Set a variety of Blogly settings by defining a class method `blogly_settings` in your application class and returning a hash with any of the following options:
  - :title - Site-wide title (used in default HEAD title) and layout H1
  - :date_format - Strftime format for styling dates
  - :time_format - Strftime format for styling times
  - :comments - Sets type of comments to use (:facebook or nil for now, :discus coming in 0.5)
  - :facebook_like - If set to false, disables Facebook "like" button on articles (what, don't you want to go viral and shit?)
  - :typekit - If set, automatically includes your typekit bundle (based on bundle ID)

## Roadmap
- 0.15: Tests, tests, tests
- 0.2: RSS feedage
- 0.25: Rake tasks to generate new blog, new articles within a blog
- 0.3: Markdown preprocessing for hiddenness, `section` grouping, summaries; undated "pages"
- 0.35: Code syntax highlighting
- 0.4: Multi-device layouting
- 0.5: Discus commenting
- 0.6: Built-in themes

## Contributing to blogly
- Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
- Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
- Fork the project
- Start a feature/bugfix branch
- Commit and push until you are happy with your contribution
- Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
- Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright
Copyright (c) 2011 Mike Laurence. See LICENSE.txt for further details.

