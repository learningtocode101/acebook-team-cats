require 'rails_helper'

def submit_post
  click_link 'New post'
  fill_in 'Message', with: 'Hello, world!'
  click_button 'Submit'
end

def submit_second_post
  click_link 'New post'
  fill_in 'Message', with: 'Second message'
  click_button 'Submit'
end

def submit_multiline_post
  click_link 'New post'
  fill_in 'Message', with: "Hello, world! \nGoodbye, world!"
  click_button 'Submit'
end

def submit_empty_post
  click_link 'New post'
  fill_in 'Message', with: ""
  click_button 'Submit'
end

def submit_post_edit
  click_link 'Hello, world'
  fill_in 'Message', with: 'Goodbye, world!'
  click_button 'Edit'
end

def submit_empty_post_edit
  click_link 'Hello, world'
  fill_in 'Message', with: ''
  click_button 'Edit'
end
