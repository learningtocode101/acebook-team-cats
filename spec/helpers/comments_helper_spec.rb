require 'rails_helper'

def submit_comment
  fill_in 'message', with: 'Comment, world!'
  click_button 'Submit'
end

def submit_empty_comment
  fill_in 'message', with: ''
  click_button 'Submit'
end

def edit_comment
  click_link 'Comment, world!'
  fill_in 'Message', with: 'Another comment, world!'
  click_button 'Edit'
end

def submit_empty_comment_edit
  click_link 'Comment, world!'
  fill_in 'Message', with: ''
  click_button 'Edit'
end
