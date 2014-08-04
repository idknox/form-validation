require 'rails_helper'
require 'capybara/rails'

feature 'Task lists' do

  scenario 'User can view task lists' do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    TaskList.create!(name: "Household Chores")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    expect(page).to have_content("Work List")
    expect(page).to have_content("Household Chores")
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