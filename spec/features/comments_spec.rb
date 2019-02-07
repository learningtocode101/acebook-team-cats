RSpec.feature 'Comments', type: :feature do
  describe 'Making a comment' do
    context 'Successful' do
      scenario 'User can submit a comment on their wall' do
        sign_up
        click_link 'New post'
        fill_in 'Message', with: 'Hello, world!'
        click_button 'Submit'
        fill_in 'message', with: 'Comment, world!'
        click_button 'Submit'
        expect(page).to have_content('Comment, world!')
      end

      scenario "User can comment on someone else's wall and stays there" do
        sign_up
        click_link 'New post'
        fill_in 'Message', with: 'Hello, world!'
        click_button 'Submit'
        fill_in 'message', with: 'Comment, world!'
        click_button 'Submit'
        click_link 'Sign Out'
        second_user_sign_up
        visit '/users/davethecat@katze.com'
        fill_in 'message', with: 'Hi Dave!'
        click_button 'Submit'
        expect(page).to have_content('Hi Dave!')
        expect(page.current_path).to eq('/users/davethecat@katze.com')
      end
    end

    context 'Unsuccessful' do
      scenario 'User cannot submit empty comment' do
        sign_up
        click_link 'New post'
        fill_in 'Message', with: 'Hello, world!'
        click_button 'Submit'
        fill_in 'message', with: ''
        click_button 'Submit'
        expect(page).to have_content("Your new post couldn't be created!")
      end
    end
  end

  describe 'Editing a comment' do
    context 'Successful' do
      scenario 'User can update their comments' do
        sign_up
        click_link 'New post'
        fill_in 'Message', with: 'Hello, world!'
        click_button 'Submit'
        fill_in 'message', with: 'Comment, world!'
        click_button 'Submit'
        click_link 'Comment, world!'
        fill_in 'Message', with: 'Another comment, world!'
        click_button 'Edit'
        expect(page).to have_content('Another comment, world!')
      end
    end

    context 'Unsuccessful' do
      scenario 'User cannot make comment blank after edit' do
        sign_up
        click_link 'New post'
        fill_in 'Message', with: 'Hello, world!'
        click_button 'Submit'
        fill_in 'message', with: 'Comment, world!'
        click_button 'Submit'
        click_link 'Comment, world!'
        fill_in 'Message', with: ''
        click_button 'Edit'
        expect(page).to have_content("Comment can't be blank")
      end

      scenario "User cannot update another user's comments" do
        sign_up
        click_link 'New post'
        fill_in 'Message', with: 'Hello, world!'
        click_button 'Submit'
        fill_in 'message', with: 'Comment, world!'
        click_button 'Submit'
        click_link 'Sign Out'
        second_user_sign_up
        visit '/users/davethecat@katze.com'
        expect(page).not_to have_link("Comment, world!")
        expect(page).to have_content("Comment, world!")
      end
    end
  end

  describe 'Deleting a comment' do
    context 'Successful' do
      scenario 'User can delete their comments' do
        sign_up
        click_link 'New post'
        fill_in 'Message', with: 'Hello, world!'
        click_button 'Submit'
        fill_in 'message', with: 'Comment, world!'
        click_button 'Submit'
        click_link 'Comment, world!'
        click_link 'Delete'
        expect(page).not_to have_content('Comment, world!')
      end
    end

    context 'Unsuccessful' do
      scenario "User cannot delete another user's comments" do
        sign_up
        click_link 'New post'
        fill_in 'Message', with: 'Hello, world!'
        click_button 'Submit'
        fill_in 'message', with: 'Comment, world!'
        click_button 'Submit'
        click_link 'Sign Out'
        second_user_sign_up
        visit '/users/davethecat@katze.com'
        expect(page).not_to have_link("Comment, world!")
        expect(page).to have_content("Comment, world!")
      end
    end
  end
end
