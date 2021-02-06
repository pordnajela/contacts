RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner[:active_record,{connection: :primary}].clean_with(:truncation)
    DatabaseCleaner[:active_record,{connection: :master}].clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner[:active_record,{connection: :primary}].strategy = :transaction
    DatabaseCleaner[:active_record,{connection: :master}].strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner[:active_record,{connection: :primary}].strategy = :truncation
    DatabaseCleaner[:active_record,{connection: :master}].strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner[:active_record,{connection: :primary}].start
    DatabaseCleaner[:active_record,{connection: :master}].start
  end

  config.append_after(:each) do
    DatabaseCleaner[:active_record,{connection: :primary}].clean
    DatabaseCleaner[:active_record,{connection: :master}].clean
  end
end