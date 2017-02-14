RSpec.configure do |config|
  config.before(:suite) do
  	puts "before trunc",User.all.count
    DatabaseCleaner.clean_with(:truncation)
    puts "after trunc",User.all.count
    Rails.application.load_seed
    puts "after load seed",User.all.count

  end
end
