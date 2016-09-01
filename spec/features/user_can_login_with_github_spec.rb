# require 'rails_helper'
#
# RSpec.feature "user can login with github" do
#   scenario "log in" do
#     stub_omniauth
#     visit "/"
#     expect(page.status_code).to eq 200
#
#     click_on "Sign in with Github"
#
#     expect(current_path).to eq user_path(:deborahleehamel)
#     expect(page).to have_content "Deborah Hamel"
#     expect(page).to have_link "Logout"
#     expect(page).to_not have_link "Login"
#   end
# end
