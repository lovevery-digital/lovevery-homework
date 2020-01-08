# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

def create_product(name="product1", desc="description2", price=1000, age_low=0, age_high=12)
  Product.create!(
    name: name,
    description: desc,
    price_cents: price,
    age_low_weeks: age_low,
    age_high_weeks: age_high)
end

def create_child
  Child.create!(
    full_name: "Test Child",
    parent_name: "Parent Name",
    birthdate: Date.today - 1.month,
    user_facing_id: SecureRandom.uuid)
end
