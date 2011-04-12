module Blogly
  
  def self.included(app)
    
    app.before do
      @settings = app.settings
    end
    
    app.get "/" do
      haml_ app, :index
    end
    
    def haml_(app, name, options = {})
      app_views_path = app.views || './views'
      blogly_views_path = File.join(File.dirname(__FILE__), '/blogly/views')
      @path = blogly_views_path unless File.exist?(File.join(app_views_path, "#{name}.haml"))

      output = haml(:index, :views => @path, :layout => false)

      app_layout_path = File.join(app_views_path, 'layout.haml')
      layout_path = File.exist?(app_layout_path) ? app_layout_path : File.join(blogly_views_path, 'layout.haml')
      layout = Tilt[:haml].new(layout_path, 1, {})
      layout.render self, {} { output }
    end
  end
  
end


__END__

@@ index
%div.title Yo!