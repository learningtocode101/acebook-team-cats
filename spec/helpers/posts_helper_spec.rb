require 'rails_helper'

def submit_post
  click_link 'New post'
  fill_in 'Message', with: 'Hello, world!'
  click_button 'Submit'
end
