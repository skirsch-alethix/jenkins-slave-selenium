
Capybara.register_driver :selenium do |app|
  require 'selenium/webdriver'

  options = Selenium::WebDriver::Firefox::Options.new
  options.args << '--headless'
  Capybara::Selenium::Driver.new(app, :browser => :firefox, options: options)
end


Before do
  Capybara.current_driver = :selenium
  SimpliTest.driver = 'selenium'
end

World(CustomSeleniumHelpers)
