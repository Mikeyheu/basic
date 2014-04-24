require 'spec_helper'

feature 'Upload' do
  scenario 'with valid image' do
    visit images_path
    click_link 'Upload Image'
    # fill_in 'Email', with: 'mike@heu.com'
    # fill_in 'Password', with: 'password'
    # click_button 'Submit'
    # expect(page).to have_text 'mike@heu.com'
    # click upload link
    # add fields
    # select file to upload
    # expect page to have thumbnails
  end
end