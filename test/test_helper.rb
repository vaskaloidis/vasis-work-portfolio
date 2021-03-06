ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'faker'
require 'minitest/reporters'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(color: true)]
  # Load Portfolio Data
  Vkaloidis::Application.load_tasks
  Rake::Task['db:schema:load'].invoke
end
