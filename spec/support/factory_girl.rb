require_relative 'external_request'

RSpec.configure do |config|

  config.before(:suite) do
    if ENV['OSEM_FACTORY_LINT'] != 'false'
      mock_commercial_request
      FactoryGirl.lint
      DatabaseCleaner.clean_with(:truncation)
    puts "after factory",User.all.count

    end
  end

end
