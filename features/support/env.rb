require "date"
require "fig_newton"
require "gmail"
require "json"
require "net/http"
require "nokogiri"
require "open-uri"
require "page-object"
require "parallel_tests"
require "require_all"
require "rest-client"
require "roo"
require "rspec"
require "selenium-webdriver"
require "uri"
require "watir"
require "imatcher"
require "capybara-screenshot/cucumber"
require "chunky_png"
require "faker"
require "mongo"
require "webdrivers"
require "eyes_selenium"


World(PageObject::PageFactory)

def browser
  (ENV["BROWSER"] ||= "chrome").downcase.to_sym
end

def machine
  (ENV["MACHINE"] ||= "local").downcase.to_sym
end

def mobile
  (ENV["MOBILE"] ||= "false").downcase.to_sym
end

def mac
  (ENV["MAC"] ||= "true").downcase.to_sym
end

def debug
  ENV["DEBUG"] ||= nil
end