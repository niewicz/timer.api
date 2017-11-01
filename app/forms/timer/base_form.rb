class Timer::BaseForm < Dry::Validation::Schema::Form

  configure do |config|
    config.messages = :i18n
  end
  
end