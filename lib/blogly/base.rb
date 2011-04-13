require 'rdiscount'
require 'rss/atom'

module Blogly
  module Base
    
    def self.included(app)
      
      # Settings & setup
      
      app.before do
        @views_path = app.views || './views'
        @settings = {
          :title => 'My new blogly blog',
          :date_format => '%B %d, %Y',
          :time_format => '%I:%M%p',
          :comments => :facebook
        }
        @settings.merge! app.blogly_settings rescue nil
      end
      
      
      
      # Articles
      
      app.get "/" do
        @articles = articles || []
        haml :index, :layout => true
      end
      
      app.get "/:year/:month/:day/:title" do
        @show_comments = true
        @article = article(params[:year], params[:month], params[:day], params[:title])
        haml :show, :layout => true
      end
      
      
      
      # Stylesheets
      
      app.get '/app.css' do
        scss :app
      end
      
      
      
      # Helpers
      
      protected
      
      def articles
        Dir.glob(File.join(@views_path, 'articles/*.md'))
      end
      
      def article(year, month, day, title)
        Dir.glob(File.join(@views_path, "articles/#{year}-#{month}-#{day}*#{title}.md")).first
      end
      
      def facebook_like_button(url)
        %[<iframe src="http://www.facebook.com/plugins/like.php?href=#{url}&amp;layout=button_count&amp;show_faces=true&amp;width=120&amp;action=like&amp;font&amp;colorscheme=light&amp;height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:120px; height:21px;" allowTransparency="true"></iframe>]
      end
      
      def comments(url)
        case @settings[:comments]
        when :facebook
          app_id = nil
          %[<div id="fb-root"></div><script src="http://connect.facebook.net/en_US/all.js#appId=#{app_id}&amp;xfbml=1"></script><fb:comments href="#{url}" num_posts="5" width="500"></fb:comments>]
        end
      end
    end
    
  end
end