task :default => :test

task :test do
  require './init'
  Dir.foreach(ROOT_PATH + '/test') do |test|
    next unless test.match(/\.rb$/)
    next if test.match(/^test_helper/)
    begin
      sh "ruby -I test/ test/#{test}"
    rescue
      next
    end
  end
end
