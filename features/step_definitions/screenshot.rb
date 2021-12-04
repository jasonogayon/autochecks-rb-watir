Then(/^Aplitools compares screenshots of (.*?)$/) do |page|
  eyes = Applitools::Selenium::Eyes.new
  eyes.api_key = FigNewton.eyes_key
  eyes.force_full_page_screenshot = true

  browser = @browser
  begin
    eyes.test(
      app_name: 'ToDoMVC React',
      test_name: 'ToDoMVC React',
      driver: browser.driver
    ) do |driver|
      eyes.check_window(page)
    end
  ensure
    eyes.abort_if_not_closed
  end
end

Then(/^IMatcher compares screenshots of (.*?)$/) do |page|
  on(TodoPage).diff(page)
end
