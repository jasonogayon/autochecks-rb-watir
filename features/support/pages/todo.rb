class TodoPage

  include PageObject
  include Capybara::Screenshot

  ROOT_DIRECTORY = File.absolute_path("../../../..", File.dirname(__FILE__))

  page_url FigNewton.todo


  # Element Locators
  button(:button_remove, :xpath => "//button[@class='destroy']")
  h1(:header, :xpath => "//h1[.='todos']")
  text_field(:input_new_todo, :class => "new-todo")
  link(:link_active, :xpath => "//a[.='Active']")
  link(:link_completed, :xpath => "//a[.='Completed']")
  unordered_list(:list_todos, :class => "todo-list")
  span(:span_count_todo, :class => "todo-count")
  label(:toggle_all, :xpath => "//label[@for='toggle-all']")
  element(:toggle_complete, :class => "toggle")
  text_field(:input_edit_todo, :xpath => "//input[contains(@class,'edit')]")



  # Methods
  def getPlaceholder()
    input = self.input_new_todo_element
    input.wait_until(&:present?)
    return input.attribute("placeholder")
  end

  def getTodos
    list = self.list_todos_element
    list.wait_until(&:present?)
    return self.list_todos
  end

  def getTodo(todo)
    self.class.list_item(:todo, :xpath => "//li[.='#{todo}']")
    todo = self.todo_element
    return todo
  end

  def getTodoCount()
    count = self.span_count_todo_element
    return count.text
  end

  def getTodoStatus(todo)
    self.class.list_item(:todo, :xpath => "//li[.='#{todo}']")
    todo = self.todo_element
    todo.wait_until(&:present?)
    status = todo.attribute("class")
    return status == "" ? "active" : status
  end

  def addTodo(todo)
    input = self.input_new_todo_element
    input.wait_until(&:present?)
    input.set(todo)
    input.send_keys(:enter)
    wait_until do self.input_new_todo == "" end
  end

  def removeTodo(todo)
    self.class.list_item(:todo, :xpath => "//li[.='#{todo}']")
    todo = self.todo_element
    todo.wait_until(&:present?)
    todo.hover

    button = self.button_remove_element
    button.wait_until(&:present?)
    button.click
  end

  def editTodo(todoA, todoB)
    self.class.list_item(:todo, :xpath => "//li[.='#{todoA}']")
    todo = self.todo_element
    todo.wait_until(&:present?)
    todo.double_click
    sleep 1

    # Because there is no CommandOrControl Key
    # Use Backspace Instead of Either Command or Control
    input = self.input_edit_todo_element
    input.wait_until(&:present?)
    (todoA.size).times do
      input.send_keys(:backspace)
    end
    input.send_keys(todoB)
    input.send_keys(:enter)
  end

  def markAsCompleted(todo, status)
    complete = status.include?("completed")

    # Determine the Placement (Index) of the Todo from the List of Todos
    todos = getTodos().split("\n")
    index = todos.find_index {|item| item.downcase == todo.downcase }
    sleep 1

    # Click the New Todo Input
    input = self.input_new_todo_element
    input.wait_until(&:present?)
    input.click
    sleep 1

    # Because we are Unable to Click the Input.Toggle Element Properly
    # Use Tabs Key Press to Select the Todo
    # Then Use Space Key Press to Mark the Todo as Completed/Active
    keys = []
    (index + 2).times do
      keys << :tab
    end
    keys << :space
    input.send_keys(keys)
  end

  def markAllAsCompleted(status)
    toggle = self.toggle_all_element
    toggle.wait_until(&:present?)
    toggle.click
  end

  def viewTodos(status)
    complete = status.include?("completed")

    active = self.link_active_element
    active.wait_until(&:present?)
    completed = self.link_completed_element
    completed.wait_until(&:present?)

    complete ? completed.click : active.click
  end



  # Screenshot Diffing
  def diff(page)
    screenshots_dir = "/autochecks-rb-watir/reports/screens"
    orig_filename = page.downcase.strip.gsub(' ', '')
    image_base = File.join(ROOT_DIRECTORY, screenshots_dir, "#{orig_filename}_base.png")
    image_new = File.join(ROOT_DIRECTORY, screenshots_dir, "#{orig_filename}_new.png")
    image_diff = File.join(ROOT_DIRECTORY, screenshots_dir, "#{orig_filename}_diff.png")

    save_screenshot(image_new)
    save_screenshot(image_base) if !File.file?(image_base)

    cmp = Imatcher::Matcher.new threshold: 0.05
    res = cmp.compare(image_base, image_new)
    if !res.match?
      res.difference_image.save(image_diff)
      puts `tput setaf 5` + "Difference found:\nFilepath: #{image_diff}." + `tput sgr0`
    end
  end

end