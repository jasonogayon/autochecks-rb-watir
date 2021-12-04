# Browser driver paths
path_chromedrvr = Selenium::WebDriver::Chrome.path

# Add SSL certificate
ENV["SSL_CERT_FILE"] = "#{File.expand_path(File.dirname(__FILE__))}/cacert.pem"

# Start browser on a desired environment
unless browser == :none
  if browser == :headless
    browser = Watir::Browser.new :chrome, headless: true
  else
    capabilities = Selenium::WebDriver.for :chrome, driver_path: path_chromedrvr
    browser = Watir::Browser.new capabilities
  end
  browser.driver.manage.window.resize_to(1440, 1440)
end


Before do
  begin
    tries ||= 3
    unless browser == :none
      @browser = browser
      @browser.cookies.clear
      @browser.execute_script("localStorage.clear()")
      @browser.execute_script("sessionStorage.clear()")
      @browser.driver.manage.window.maximize
    end
  rescue
    retry unless (tries -= 1).zero?
  end
end


at_exit do
  browser.close unless browser.nil?
end