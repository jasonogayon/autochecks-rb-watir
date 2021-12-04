Feature: ToDoMVC React Web App

  Background:
    Given user is in the todos page

  @todos @add
  Scenario: Add a Single Todo
    When user adds a "a sample todo" todo
    Then user sees that the "a sample todo" todo is successfully added
    And user sees that the todo count is "1 item left"

  @todos @add
  Scenario: Add Multiple Todos
    When user adds a "todo #1" todo
    And user adds a "todo #2" todo
    And user adds a "todo #3" todo
    Then user sees that the "todo #1" todo is successfully added
    And user sees that the "todo #2" todo is successfully added
    And user sees that the "todo #3" todo is successfully added
    And user sees that the todo count is "3 items left"

  @todos @remove
  Scenario: Remove a Todo
    When user adds a "a sample todo" todo
    And user removes the "a sample todo" todo
    Then user sees that the "a sample todo" todo is successfully removed

  @todos @edit
  Scenario: Edit a Todo
    When user adds a "todo X" todo
    And user edits the "todo X" todo to "todo Y"
    Then user sees that the "todo X" todo is successfully edited to "todo Y"
    And user sees that the todo count is "1 item left"

  @todos @status
  Scenario: Mark a Todo as Completed or Active
    When user adds a "a sample todo" todo
    And user marks the "a sample todo" todo as "completed"
    Then user sees that the "a sample todo" todo is successfully marked as "completed"
    And user sees that the todo count is "0 items left"
    When user marks the "a sample todo" todo as "active"
    Then user sees that the "a sample todo" todo is successfully marked as "active"
    And user sees that the todo count is "1 item left"

  @todos @status
  Scenario: Mark All Todos as Completed or Active
    When user adds a "todo #1" todo
    And user adds a "todo #2" todo
    And user adds a "todo #3" todo
    And user marks all todos as "completed"
    Then user sees that all todos are successfully marked as "completed"
    And user sees that the todo count is "0 items left"
    When user marks all todos as "active"
    Then user sees that all todos are successfully marked as "active"
    And user sees that the todo count is "3 items left"

  @todos @placeholder
  Scenario: Todo Input Placeholder
    Then todo input has a placeholder value of "What needs to be done?"

  @todos @view
  Scenario: View Completed or Active Todos
    When user adds a "todo #1" todo
    And user adds a "todo #2" todo
    And user adds a "todo #3" todo
    And user marks the "todo #2" todo as "completed"
    And user views the "completed" todos
    Then user sees that the "todo #2" todo is listed
    And user sees that the "todo #1" todo is not listed
    And user sees that the "todo #3" todo is not listed
    And user sees that the todo count is "2 items left"
    When user views the "active" todos
    And user sees that the "todo #1" todo is listed
    And user sees that the "todo #3" todo is listed
    Then user sees that the "todo #2" todo is not listed
    And user sees that the todo count is "2 items left"

  @todos @view
  Scenario: Add a Todo from the Completed Page
    When user adds a "todo #1" todo
    And user adds a "todo #2" todo
    And user adds a "todo #3" todo
    And user views the "completed" todos
    And user adds a "a sample todo" todo
    Then user sees that the "a sample todo" todo is not listed
    And user sees that the todo count is "4 items left"
    When user views the "active" todos
    And user sees that the "a sample todo" todo is listed
    And user sees that the todo count is "4 items left"



  # @todos @screen @eyes
  # Scenario: Home Page Screenshot Diffing (Aplitools Eyes)
  #   Then Aplitools can see that the "Home Page" has not changed since before

  # @todos @screen @capybara
  # Scenario: Home Page Screenshot Diffing (Capybara Imatcher)
  #   Then user can see that the "Home Page" has not changed since before
