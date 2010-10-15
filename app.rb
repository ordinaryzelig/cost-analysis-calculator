require './init'
enable :run# if ARGV[0] == __FILE__
set :haml, :format => :html5

get '/' do
  haml :index
end
