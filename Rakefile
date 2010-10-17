task :default => :test

def Dir.run_files_in(path)
  foreach(path) do |test|
    next unless test.match(/\.rb$/)
    next if test.match(/^test_helper/)
    begin
      sh "ruby -I test/ #{File.join(path, test)}"
    rescue
      next
    end
  end
end
task :test do
  require './init'
  Dir.run_files_in(ROOT_PATH + '/test/unit')
  Dir.run_files_in(ROOT_PATH + '/test/integration')
end
