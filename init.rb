ROOT_PATH = File.dirname(__FILE__)

require 'sinatra'
require 'yaml'
require 'sass'

# require model files.
dirs = ['/models', '/lib']
dirs.each do |dir|
  load_paths = [ROOT_PATH, File.join(ROOT_PATH, dir)]
  $LOAD_PATH.unshift(*load_paths)
  Dir.foreach(ROOT_PATH + dir) do |file_name|
    next unless file_name.match(/\.rb$/)
    require file_name
  end
end

configure(:development) do |config|
  require "sinatra/reloader"
  config.also_reload 'models/*.rb', '*.haml', '*.sass'
end

