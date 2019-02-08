require 'rails_helper'

def fill_in_sign_up_details
  visit '/'
  fill_in :first_name, with: 'Dave'
  fill_in :last_name, with: 'Katze'
  fill_in :email, with: 'davethecat@katze.com'
  fill_in :password, with: 'Gato123'
  fill_in :birthday, with: '2000/10/10'
  fill_in :gender, with: 'Male'
end

def create_user
  tom = User.create(first_name: 'Tom', last_name: 'Lawrence', birthday: '2000-01-01', password: 'nerds123', gender: 'Male', email: 'tom@hotmail.com')
  session[:user_id] = tom.id
end

def sign_up
  visit '/'
  fill_in :first_name, with: 'Dave'
  fill_in :last_name, with: 'Katze'
  fill_in :email, with: 'davethecat@katze.com'
  fill_in :password, with: 'Gato123'
  fill_in :birthday, with: '2000/10/10'
  fill_in :gender, with: 'Male'
  click_button 'Sign Up'
end

def second_user_sign_up
  visit '/'
  fill_in :first_name, with: 'Jane'
  fill_in :last_name, with: 'Gato'
  fill_in :email, with: 'jane@gato.com'
  fill_in :password, with: 'Katze123'
  fill_in :birthday, with: '1999/05/05'
  fill_in :gender, with: 'Female'
  click_button 'Sign Up'
end
