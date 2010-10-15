ROOT_PATH = File.dirname(__FILE__)

require 'sinatra'
load_paths = [ROOT_PATH, ROOT_PATH + '/models']
$LOAD_PATH.unshift(*load_paths)

Dir.foreach(ROOT_PATH + '/models') do |file_name|
  next unless file_name.match(/\.rb$/)
  require file_name
end
