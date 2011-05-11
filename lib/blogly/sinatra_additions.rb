# Override Sinatra's find_template method to enable overrideable gem views
# (first attempts to find views in the apps's view path, typically ./views, then checks the gem's view path)
module Sinatra
  module Templates
    alias find_template_ find_template

    def find_template(views, name, engine, &block)
      find_template_(views, name, engine, &block)

      blogly_views_path = File.join(File.dirname(__FILE__), 'views')
      find_template_(blogly_views_path, name, engine, &block)
    end
  end
end