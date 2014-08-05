require 'rails_helper'
require 'capybara/rails'

feature 'Task lists' do

  before :each do
    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
  end

  scenario "user can add tasks" do

    click_on "Add Task List"

    fill_in "Name", :with => "Whatever"

    click_on "Create Task List"

    expect(page).to have_content "Task List was created successfully!"
    expect(page).to have_content "Whatever", "My Lists"
  end

  scenario "doesn't allow task with blank name to be created" do
    click_on "Add Task List"
    click_on "Create Task List"

    expect(page).to have_content "Your task list could not be created"
    expect(page).to have_content "Add a task list"
  end

  scenario "user can edit task_list" do
    click_on "Add Task List"

    fill_in "Name", :with => "Whatever"

    click_on "Create Task List"

    expect(page).to have_content "Task List was created successfully!"
    expect(page).to have_content "Whatever", "My Lists"
    click_link "Edit"

    fill_in "Name", :with => "New name"
    click_on "Update Task List"

    expect(page).to have_content "Your task list was successfully updated", "New name"
  end
end

feature "About Page" do
  scenario "User can view About Page" do
    visit "/"

    click_link "About"

    expect(page).to have_content "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla vel tristique lectus, vitae tristique urna. Integer
  facilisis bibendum urna, vitae tempor sapien blandit sed. Nulla eros magna, suscipit eget magna sed, placerat dictum
  elit. Suspendisse potenti. Maecenas consequat magna eu urna rhoncus tristique. Proin hendrerit in quam quis imperdiet.
  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam et hendrerit est."
  end


end