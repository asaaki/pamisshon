# encoding: utf-8
here = File.dirname(__FILE__)
$LOAD_PATH.unshift(File.join(here, '..', 'lib'))
$LOAD_PATH.unshift(here)

require 'rspec'
require 'pamisshon'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{here}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|

end

