require 'blogly/additions'
require 'blogly/sinatra_additions'
require 'blogly/article'
require 'blogly/base'

if defined?(Rake)
  load 'tasks/posts.rake'
end