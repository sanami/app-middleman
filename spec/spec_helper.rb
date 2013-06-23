# Initialize
ROOT_PATH = File.expand_path('../..', __FILE__)
puts ROOT_PATH

# Required folders
['lib'].each do |folder|
  $: << File.join(ROOT_PATH, folder)
end

# http://stackoverflow.com/questions/3372254/how-to-tell-bundler-where-the-gemfile-is
ENV['BUNDLE_GEMFILE'] = File.join(ROOT_PATH, 'Gemfile')

require 'bundler'
Bundler.require

#ENV["RAILS_ENV"] ||= 'test'
#require 'middleman-core'
require 'rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
#Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
#  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
#  config.use_transactional_fixtures = true
end

# https://github.com/middleman/middleman/issues/737
# middleman/middleman-core/lib/middleman-core/step_definitions/server_steps.rb
def middleman_app(fixture_path)
  root_dir = File.expand_path("../fixtures/#{fixture_path}", __FILE__)

  if File.exists?(File.join(root_dir, "source"))
    ENV["MM_SOURCE"] = "source"
  else
    ENV["MM_SOURCE"] = ""
  end

  ENV["MM_ROOT"] = root_dir

  initialize_commands = @initialize_commands || []
  initialize_commands.unshift lambda {
    set :environment, @current_env || :development
    set :show_exceptions, false
  }

  @server_inst = Middleman::Application.server.inst do
    initialize_commands.each do |p|
      instance_exec(&p)
    end
  end
end
