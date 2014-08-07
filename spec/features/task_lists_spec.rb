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
    expect(page).to have_content "Task List was created successfully!"
    expect(page).to have_content "Whatever", "My Lists"
    click_link "Edit"

    fill_in "Name", :with => "New name"
    click_on "Update Task List"

    expect(page).to have_content "Your task list was successfully updated", "New name"
  end

  scenario "User can add and delete tasks" do
    click_link "Add Task"
    fill_in "Description", :with => "Do things"
    page.select "March", :from => "task_date_2i"
    page.select "6", :from => "task_date_3i"
    page.select "2015", :from => "task_date_1i"
    click_button "Create Task"

    expect(page).to have_content "Do things", "03-06-2015"
    within ".task" do
      click_on "Delete"
    end
    expect(page).to have_content "Whatever", "My Lists"
    expect(page).to_not have_content "Do things", "03-06-2015"
  end

  scenario "User can view Task List page" do
    click_link "Add Task"
    fill_in "Description", :with => "Do things"
    page.select "March", :from => "task_date_2i"
    page.select "6", :from => "task_date_3i"
    page.select "2015", :from => "task_date_1i"
    click_button "Create Task"

    click_on "Add Task List"
    fill_in "Name", :with => "Stuff"
    click_on "Create Task List"

    click_on "Whatever"
    expect(page).to have_content "Whatever", "Do things", "03-06-2015"
    expect(page).to_not have_content "Stuff"
  end

  scenario "User can complete tasks" do
    click_link "Add Task"
    fill_in "Description", :with => "Do things"
    page.select "March", :from => "task_date_2i"
    page.select "6", :from => "task_date_3i"
    page.select "2015", :from => "task_date_1i"
    click_button "Create Task"

    click_on "Complete"
    expect(page).to have_content "My Lists", "Whatever"
    expect(page).to_not have_content "Do things"
  end

  scenario "User can view completed tasks" do
    click_link "Add Task"
    fill_in "Description", :with => "Do things"
    page.select "March", :from => "task_date_2i"
    page.select "6", :from => "task_date_3i"
    page.select "2015", :from => "task_date_1i"
    click_button "Create Task"

    click_on "Complete"
    click_on "Completed"
    expect(page).to have_content "Do things", "Whatever - Completed"
  end

  scenario "tasks display sorted by date" do
    click_link "Add Task"
    fill_in "Description", :with => "Do things"
    page.select "March", :from => "task_date_2i"
    page.select "6", :from => "task_date_3i"
    page.select "2016", :from => "task_date_1i"
    click_button "Create Task"

    click_link "Add Task"
    fill_in "Description", :with => "Do things 2"
    page.select "March", :from => "task_date_2i"
    page.select "6", :from => "task_date_3i"
    page.select "2015", :from => "task_date_1i"
    click_button "Create Task"

    expect(page).to have_content "Do things 2 (212 days) - Some User Do things (578 days) - Some User"
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

  scenario "assign tasks to user" do
    click_link "Add Task"
    fill_in "Description", :with => "Do things"
    page.select "August", :from => "task_date_2i"
    page.select "5", :from => "task_date_3i"
    page.select "2015", :from => "task_date_1i"
    page.select "Some User", :from => "task_user"
    click_button "Create Task"

    expect(page).to have_content "My Lists", "Do things - Some User"
  end
  scenario "user cannot create a past task" do
    click_link "Add Task"
    fill_in "Description", :with => "Do things"
    page.select "August", :from => "task_date_2i"
    page.select "5", :from => "task_date_3i"
    page.select "2014", :from => "task_date_1i"
    page.select "Some User", :from => "task_user"
    click_button "Create Task"

    expect(page).to have_content "Add a task", "Please select a future date"
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