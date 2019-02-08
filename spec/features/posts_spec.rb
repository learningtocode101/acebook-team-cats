RSpec.feature 'Posts', type: :feature do
  describe 'Making a post' do
    context 'Successful' do
      scenario 'User submits a post' do
        sign_up
        submit_post
        expect(page).to have_content('Hello, world!')
      end

      scenario 'User submits a multiline post' do
        sign_up
        submit_multiline_post
        expect(page.text).to have_content("Hello, world! \nGoodbye, world!")
      end
    end

    context 'Unsuccessful' do
      scenario 'User cannot submit an empty post' do
        sign_up
        submit_empty_post
        expect(page).to have_content("Your new post couldn't be created!")
      end
    end
  end

  describe 'Viewing posts' do
    scenario 'User views newest posts first' do
      sign_up
      submit_post
      submit_second_post
      expect('Second message').to appear_before('Hello, world!')
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
        submit_post
        submit_post_edit
        expect(page).to have_content('Goodbye, world!')
        expect(page).not_to have_content('Hello, world')
      end

      scenario "User edits their own post on another user's wall" do
        sign_up
        click_link 'Sign Out'
        second_user_sign_up
        visit '/users/davethecat@katze.com'
        submit_post
        submit_post_edit
        expect(page).to have_link("Goodbye, world!")
      end
    end

    context 'Unsuccessful' do
      scenario 'User cannot edit post to be blank' do
        sign_up
        submit_post
        submit_empty_post_edit
        expect(page).to have_content('Message')
      end

      scenario "User cannot edit another user's posts" do
        sign_up
        submit_post
        click_link 'Sign Out'
        second_user_sign_up
        visit '/users/davethecat@katze.com'
        expect(page).not_to have_link("Hello, world!")
        expect(page).to have_content("Hello, world!")
      end
    end
  end

  describe 'Deleting posts' do
    context 'Successful' do
      scenario 'User can delete their own post' do
        sign_up
        submit_post
        click_link 'Hello, world!'
        click_link 'Delete'
        expect(page).not_to have_content('Hello, world!')
      end

      scenario "User can delete their own posts on someone else's wall" do
        second_user_sign_up
        visit '/users/davethecat@katze.com'
        submit_post
        click_link 'Hello, world!'
        click_link 'Delete'
        expect(page).not_to have_content('Hello, world!')
      end
    end

    context 'Unsuccessful' do
      scenario 'User cannot delete other user posts' do
        sign_up
        submit_post
        click_link 'Sign Out'
        second_user_sign_up
        visit '/users/davethecat@katze.com'
        expect(page).not_to have_link("Hello, world!")
        expect(page).to have_content("Hello, world!")
      end
    end
  end
end
