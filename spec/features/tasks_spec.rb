require 'rails_helper'
require 'capybara/rails'

feature 'Tasks' do

  before :each do
    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"

    click_on "Add Task List"
    fill_in "Name", :with => "Whatever"
    click_on "Create Task list"
  end

  scenario "User can add and delete tasks" do
    click_link "Add Task"
    fill_in "Description", :with => "Do things"
    fill_in "task_date", :with => "03/06/2015"
    page.select "Some User", :from => "task_assigned_to"
    click_button "Create Task"

    expect(page).to have_content "Do things", "03-06-2015"
    within ".task" do
      click_on "Delete"
    end
    expect(page).to have_content "Whatever", "My Lists"
    expect(page).to_not have_content "Do things", "03-06-2015"
  end

  scenario "assign tasks to user" do
    click_link "Add Task"
    fill_in "Description", :with => "Do things"
    fill_in "task_date", :with => "03/06/2015"
    page.select "Some User", :from => "task_assigned_to"
    click_button "Create Task"

    expect(page).to have_content "My Lists", "Do things - Some User"
  end

  scenario "user cannot create blank task" do
    click_link "Add Task"
    page.select "Some User", :from => "task_assigned_to"
    fill_in "task_date", :with => "03/06/2015"
    click_button "Create Task"

    expect(page).to have_content "Add a task", "Your task could not be created"
  end

  scenario "user cannot create a past task" do
    click_link "Add Task"
    fill_in "Description", :with => "Do things"
    fill_in "task_date", :with => "03/06/2014"
    page.select "Some User", :from => "task_assigned_to"
    click_button "Create Task"

    expect(page).to have_content "Add a task"
    expect(page).to have_content "Please select a future date"
  end

  scenario "User can complete tasks" do
    click_link "Add Task"
    fill_in "Description", :with => "Do things"
    fill_in "task_date", :with => "03/06/2015"
    page.select "Some User", :from => "task_assigned_to"
    click_button "Create Task"

    click_on "Complete"
    expect(page).to have_content "My Lists", "Whatever"
    expect(page).to_not have_content "Do things"
  end

  scenario "User can view completed tasks" do
    click_link "Add Task"
    fill_in "Description", :with => "Do things"
    fill_in "task_date", :with => "03/06/2015"
    page.select "Some User", :from => "task_assigned_to"
    click_button "Create Task"

    click_on "Complete"
    click_on "Completed"
    expect(page).to have_content "Do things", "Whatever - Completed"
  end

  scenario "tasks display sorted by date" do
    click_link "Add Task"
    fill_in "Description", :with => "Do things"
    fill_in "task_date", :with => "03/06/2016"
    page.select "Some User", :from => "task_assigned_to"
    click_button "Create Task"

    click_link "Add Task"
    fill_in "Description", :with => "Do things 2"
    fill_in "task_date", :with => "03/06/2015"
    page.select "Some User", :from => "task_assigned_to"
    click_button "Create Task"

    expect(page).to have_content "Do things 2 (299 days) - Some User Delete Do things (665 days) - Some User"
  end

  scenario "user can view their assigned tasks" do
    click_link "Add Task"
    fill_in "Description", :with => "Do things"
    fill_in "task_date", :with => "03/06/2015"
    page.select "Some User", :from => "task_assigned_to"
    click_button "Create Task"

    click_link "Add Task"
    fill_in "Description", :with => "Do things2"
    fill_in "task_date", :with => "03/06/2015"
    page.select "Some User", :from => "task_assigned_to"
    click_button "Create Task"

    click_on "View Tasks"
    expect(page).to have_content "Some User's Tasks", "Do thins2", "Do things"
  end

  scenario "Task must have user assigned" do
    click_link "Add Task"
    fill_in "Description", :with => "Do things"
    fill_in "task_date", :with => "03/06/2015"
    click_button "Create Task"

    expect(page).to have_content "Task must have user assigned", "Whatever"
  end

  scenario "user can search for tasks" do
    click_link "Add Task"
    fill_in "Description", :with => "Event with gSchool on Monday"
    fill_in "task_date", :with => "03/06/2015"
    page.select "Some User", :from => "task_assigned_to"
    click_button "Create Task"

    click_link "Add Task"
    fill_in "Description", :with => "Event with Turing"
    fill_in "task_date", :with => "03/06/2015"
    page.select "Some User", :from => "task_assigned_to"
    click_button "Create Task"

    fill_in "q", :with => "gSchool"
    click_on "Search Tasks"
    expect(page).to have_content "Event with gSchool", "Found Tasks"
    expect(page).to_not have_content "Event with Turing", "My Lists"
  end
end