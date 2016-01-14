require 'irb/completion'
require 'rubygems'
begin
  require 'interactive_editor'
rescue LoadError
  STDERR.puts 'gem install interactive_editor'
end
