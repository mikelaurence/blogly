# Override Sinatra's find_template method to enable overrideable gem views
# (first attempts to find views in the apps's view path, typically ./views, then checks the gem's view path)
module Sinatra
  module Templates
    def find_template(views, name, engine)
      Tilt.mappings.each do |ext, klass|
        next unless klass == engine
        yield ::File.join(views, "#{name}.#{ext}")
      end
      
      blogly_views_path = File.join(File.dirname(__FILE__), 'views')
      Tilt.mappings.each do |ext, klass|
        next unless klass == engine
        yield ::File.join(blogly_views_path, "#{name}.#{ext}")
      end
    end
  end
end