require 'rails_helper'
require 'capybara/rails'

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