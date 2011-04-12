require 'rdiscount'

module Blogly
  
  def self.included(app)
    
    app.before do
      @views_path = app.views || './views'
      @settings = {
        :title => 'My new blogly blog',
        :date_format => '%B %d, %Y',
        :time_format => '%I:%M%p'
      }
      @settings.merge! app.blogly_settings rescue nil
    end
    
    app.get "/" do
      @articles = articles(app) || []
      haml_ :index, :layout => true
    end
    
    app.get '/app.css' do
      scss :app
    end
    
    
    protected
    
    def articles(app)
      Dir.glob(File.join(@views_path, 'articles/*.md'))
    end
    
    def facebook_like_button(url)
      %[<iframe src="http://www.facebook.com/plugins/like.php?href=#{url}&amp;layout=button_count&amp;show_faces=true&amp;width=120&amp;action=like&amp;font&amp;colorscheme=light&amp;height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:120px; height:21px;" allowTransparency="true"></iframe>]
    end
        
    def haml_(name, options = {})
      blogly_views_path = File.join(File.dirname(__FILE__), '/blogly/views')
      @path = blogly_views_path unless File.exist?(File.join(@views_path, "#{name}.haml"))

      output = haml(name, :views => @path, :layout => false, :locals => options[:locals])

      if options[:layout]
        app_layout_path = File.join(@views_path, 'layout.haml')
        layout_path = File.exist?(app_layout_path) ? app_layout_path : File.join(blogly_views_path, 'layout.haml')
        layout = Tilt[:haml].new(layout_path, 1, {})
        layout.render self, {} { output }
      else
        output
      end
    end
  end
  
end


__END__

@@ index
%div.title Yo!