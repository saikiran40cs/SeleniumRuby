#This is to import the selenium webdriver into ruby
require "selenium-webdriver"

class SelTest
  def setUpBrowserInstance(browser="chrome")
    case browser
    when "firefox"
      #Declare the webdriver for firefox
      geckodriver_path = File.join(".","Drivers","geckodriver.exe")
      puts geckodriver_path
      Selenium::WebDriver::Firefox::driver_path = geckodriver_path
      @driver = Selenium::WebDriver.for :firefox

    when "chrome"
      #Declare the webdriver for chrome
      chromedriver_path = File.join(".","Drivers","chromedriver.exe")
      puts chromedriver_path
      Selenium::WebDriver::Chrome.driver_path = chromedriver_path
      @driver = Selenium::WebDriver.for :chrome

    when "ie"
      #Declare the webdriver for chrome
      iedriver_path = File.join(".","Drivers","IEDriverServer.exe")
      puts iedriver_path
      Selenium::WebDriver::IE.driver_path = iedriver_path
      @driver = Selenium::WebDriver.for :ie
    else
      puts "No driver provided"
    end
    @driver.manage.window.maximize
    @driver.manage.timeouts.implicit_wait = 30
    @driver.manage.timeouts.page_load = 30
  end

  def testTheGooglePage(urls="http://google.com")
    @driver.navigate.to urls

    element = @driver.find_element(:name, 'q')
    element.send_keys "Xpertfeed"
    element.submit
    wait = Selenium::WebDriver::Wait.new(:timeout => 30) # seconds
    begin
      element = wait.until { @driver.find_element(:xpath, "//h3[text()='Xpertfeed']") }
    ensure
      puts @driver.title
    end
  end

  def tearDownBrowserInstance()
    @driver.quit
  end
end

class TestGooglePage 
  #Exception Handling in case method doesnot exists
  begin
    # Method defined on superclass
    selTestN = SelTest.new
    selTestN.setUpBrowserInstance()
    selTestN.testTheGooglePage()
    selTestN.tearDownBrowserInstance()
  rescue => e
    print_exception(e, false)
  end

end
