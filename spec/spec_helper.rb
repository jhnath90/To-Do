require("rspec")
require("pg")
require("list")
require("task")
require('pry')
require('date')

DB = PG.connect({:dbname => "to_do_test"})

RSpec.configure do |config|
  config.before(:each) do
    DB.exec("DELETE FROM lists *;")
    DB.exec("DELETE FROM tasks *;")
    config.include Capybara::DSL
  end
end