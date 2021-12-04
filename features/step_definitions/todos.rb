Given(/^user is in the todos page$/) do
  visit(TodoPage)
end



When(/^user adds a "(.*?)" todo$/) do |todo|
  on(TodoPage).addTodo(todo)
end

When(/^user edits the "(.*?)" todo to "(.*?)"$/) do |todoA, todoB|
  on(TodoPage).editTodo(todoA, todoB)
end

When(/^user removes the "(.*?)" todo$/) do |todo|
  on(TodoPage).removeTodo(todo)
end

When(/^user marks the "(.*?)" todo as "(.*?)"$/) do |todo, status|
  on(TodoPage).markAsCompleted(todo, status)
end

When(/^user marks all todos as "(.*?)"$/) do |status|
  on(TodoPage).markAllAsCompleted(status)
end

When(/^user views the "(.*?)" todos$/) do |status|
  on(TodoPage).viewTodos(status)
end



Then(/^user sees that the "(.*?)" todo is successfully added$/) do |todo|
  expect(on(TodoPage).getTodos).to include(todo)
  expect(on(TodoPage).getTodo(todo).exists?).to eq(true)
end

Then(/^user sees that the "(.*?)" todo is successfully edited to "(.*?)"$/) do |todoA, todoB|
  expect(on(TodoPage).getTodo(todoA).exists?).to eq(false)
  expect(on(TodoPage).getTodo(todoB).exists?).to eq(true)
end

Then(/^user sees that the "(.*?)" todo is successfully removed$/) do |todo|
  expect(on(TodoPage).getTodo(todo).exists?).to eq(false)
end

Then(/^user sees that the "(.*?)" todo is successfully marked as "(.*?)"$/) do |todo, status|
  expect(on(TodoPage).getTodoStatus(todo)).to eq(status)
end

Then(/^user sees that all todos are successfully marked as "(.*?)"$/) do |status|
  todos = on(TodoPage).getTodos().split("\n")
  todos.each do |todo|
    expect(on(TodoPage).getTodoStatus(todo)).to eq(status)
  end
end

Then(/^todo input has a placeholder value of "(.*?)"$/) do |placeholder|
  expect(on(TodoPage).getPlaceholder()).to eq(placeholder)
end

Then(/^user sees that the "(.*?)" todo is listed$/) do |todo|
  expect(on(TodoPage).getTodo(todo).exists?).to eq(true)
end

Then(/^user sees that the "(.*?)" todo is not listed$/) do |todo|
  expect(on(TodoPage).getTodo(todo).exists?).to eq(false)
end

Then(/^user sees that the todo count is "(.*?)"$/) do |count|
  expect(on(TodoPage).getTodoCount()).to eq(count)
end



Then(/^(.*?) can see that the "(.*?)" has not changed since before$/) do |user, page|
  if user.downcase.include? "aplitools"
    step "Aplitools compares screenshots of #{page}"
  else
    step "IMatcher compares screenshots of #{page}"
  end
end