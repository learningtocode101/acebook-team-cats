RSpec.feature 'Posts', type: :feature do
  describe 'Making a post' do
    context 'Successful' do
      scenario 'User submits a post' do
        sign_up
        click_link 'New post'
        fill_in 'Message', with: 'Hello, world!'
        click_button 'Submit'
        expect(page).to have_content('Hello, world!')
      end

      scenario 'User submits a multiline post' do
        sign_up
        click_link 'New post'
        fill_in 'Message', with: "Hello, world! \nGoodbye, world!"
        click_button 'Submit'
        expect(page.text).to have_content("Hello, world! \nGoodbye, world!")
      end
    end

    context 'Unsuccessful' do
      scenario 'User cannot submit an empty post' do
        sign_up
        click_link 'New post'
        click_button 'Submit'
        expect(page).to have_content("Your new post couldn't be created!")
      end
    end
  end

  describe 'Viewing posts' do
    scenario 'User views newest posts first' do
      sign_up
      click_link 'New post'
      fill_in 'Message', with: 'First message'
      click_button 'Submit'
      click_link 'New post'
      fill_in 'Message', with: 'Second message'
      click_button 'Submit'
      expect('Second message').to appear_before('First message')
    end

    scenario 'User can see the time a post was submitted' do
      post = Post.create('message' => 'Time')
      sign_up
      expect(page).to have_content(post.created_at)
    end
  end

  describe 'Editing post' do
    context 'Successful' do
      scenario 'User edits a post on their own wall' do
        sign_up
        click_link 'New post'
        fill_in 'Message', with: 'Hello, world'
        click_button 'Submit'
        click_link 'Hello, world'
        fill_in 'Message', with: 'Goodbye, world!'
        click_button 'Edit'
        expect(page).to have_content('Goodbye, world!')
        expect(page).not_to have_content('Hello, world')
      end

      scenario "User edits their own post on another user's wall" do
        sign_up
        click_link 'New post'
        fill_in 'Message', with: 'Hello, world!'
        click_button 'Submit'
        click_link 'Sign Out'
        second_user_sign_up
        visit '/users/davethecat@katze.com'
        click_link 'New post'
        fill_in 'Message', with: 'Hi Dave!'
        click_button 'Submit'
        expect(page).to have_link("Hi Dave!")
      end
    end

    context 'Unsuccessful' do
      scenario 'User cannot edit post to be blank' do
        sign_up
        click_link 'New post'
        fill_in 'Message', with: 'Hello, world!'
        click_button 'Submit'
        click_link 'Hello, world!'
        fill_in 'Message', with: ''
        click_button 'Edit'
        expect(page).to have_content('Message')
      end

      scenario "User cannot edit another user's posts" do
        sign_up
        click_link 'New post'
        fill_in 'Message', with: 'Hello, world!'
        click_button 'Submit'
        click_link 'Sign Out'
        second_user_sign_up
        visit '/users/davethecat@katze.com'
        expect(page).not_to have_link("Hello, world!")
        expect(page).to have_content "Hello, world!"
      end
    end
  end

  describe 'Deleting posts' do
    context 'Successful' do
      scenario 'User can delete their own post' do
        sign_up
        click_link 'New post'
        fill_in 'Message', with: 'Hello, world!'
        click_button 'Submit'
        click_link 'Hello, world!'
        click_link 'Delete'
        expect(page).not_to have_content('Hello, world!')
      end

      scenario "User can delete their own posts on someone else's wall" do
        sign_up
        click_link 'New post'
        fill_in 'Message', with: 'Hello, world!'
        click_button 'Submit'
        click_link 'Sign Out'
        second_user_sign_up
        visit '/users/davethecat@katze.com'
        click_link 'New post'
        fill_in 'Message', with: 'Hi Dave!'
        click_button 'Submit'
        click_link 'Hi Dave!'
        click_link 'Delete'
        expect(page).not_to have_content('Hi Dave!')
      end
    end

    context 'Unsuccessful' do
      scenario 'User cannot delete other user posts' do
        sign_up
        click_link 'New post'
        fill_in 'Message', with: 'Hello, universe!'
        click_button 'Submit'
        click_link 'Sign Out'
        second_user_sign_up
        visit '/users/davethecat@katze.com'
        expect(page).not_to have_link("Hello, universe!")
        expect(page).to have_content "Hello, universe!"
      end
    end
  end
end
