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

  def teardown_selenium
    @driver.quit if @driver
  end
end
