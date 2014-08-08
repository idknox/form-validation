require 'rails_helper'
require 'capybara/rails'

feature 'Task lists' do

  before :each do
    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"

    click_on "Add Task List"
    fill_in "Name", :with => "Whatever"
    click_on "Create Task List"
  end

  scenario "user can add tasks" do
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
    click_link "Edit"
    fill_in "Name", :with => ""
    click_on "Update Task List"

    expect(page).to have_content "Your task list could not be created", "New name"

    fill_in "Name", :with => "New name"
    click_on "Update Task List"

    expect(page).to have_content "Your task list was successfully updated", "New name"
  end

  scenario "User can view Task List page" do
    click_link "Add Task"
    fill_in "Description", :with => "Do things"
    fill_in "task_date", :with => "03/06/2015"
    page.select "Some User", :from => "task_assigned_to"
    click_button "Create Task"

    click_on "Add Task List"
    fill_in "Name", :with => "Stuff"
    click_on "Create Task List"

    click_on "Whatever"
    expect(page).to have_content "Whatever", "Do things", "03-06-2015"
    expect(page).to_not have_content "Stuff"
  end

  scenario "user can delete task lists" do
    click_on "Delete"

    expect(page).to_not have_content "Whatever"
    expect(page).to have_content "My Lists"
  end

  scenario "taskless list shows message" do
    expect(page).to have_content "Nothing here to see!"
  end

  scenario "logged out user can't access any task pages" do
    click_on "Logout"

    visit "task_lists/*/tasks/new"
    expect(page).to have_content "Rails Practice Email Password About"
  end
end
