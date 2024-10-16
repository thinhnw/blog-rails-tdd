module SeleniumHelper
  def setup_selenium
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    @driver = Selenium::WebDriver.for(
      :remote,
      url: ENV['WEB_DRIVER_URL'], # Docker Compose service URL for Selenium
      capabilities: options
    )
  end

  def self.register_remote_driver
    Capybara.register_driver :remote_selenium do |app|
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--no-sandbox')
      options.add_argument('--disable-dev-shm-usage')
      options.add_argument('--headless') # Remove this line if you want to see the browser
      # options.add_argument('--window-size=1920,1080')

      # binding.irb
      Capybara::Selenium::Driver.new(
        app,
        browser: :remote,
        url: ENV['WEB_DRIVER_URL'],
        options: options
      )
    end
    Capybara.app_host = "http://web:3000"
    Capybara.javascript_driver = :remote_selenium
  end

  def teardown_selenium
    @driver.quit if @driver
  end
end
