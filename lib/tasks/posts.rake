namespace :blogly do
  namespace :posts do
    
    desc "Creates a new post with the current date and time; TITLE is optional"
    task :new do
      title = ENV['TITLE'].downcase.gsub(' ', '-') if ENV['TITLE']
      filename = [Time.now.strftime('%Y-%m-%d.%H%M'), title, 'md'].compact.join('.')
      views_path = 'views'
      file_path = File.join(views_path, 'articles', filename)

      puts "Creating blog entry at #{file_path}"
      success = system("#{ENV['EDITOR']} #{file_path}")
    end

  end
end
