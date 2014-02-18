RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.start
    FactoryGirl.lint
    DatabaseCleaner.clean
  end
end