RSpec.feature 'User authentication', type: :feature do
  describe 'Sign in' do
    context 'Successful' do
      scenario 'User successfully signs in' do
        fill_in_sign_up_details
        click_button 'Sign Up'
        visit '/'
        fill_in :sign_in_email, with: 'davethecat@katze.com'
        fill_in :sign_in_password, with: 'Gato123'
        click_button 'Sign In'
        expect(page.current_path).to eq('/users/davethecat@katze.com')
      end
    end

    context 'Unsuccessful' do
      scenario 'User gets notice when failing to sign in' do
        fill_in_sign_up_details
        click_button 'Sign Up'
        visit '/'
        fill_in :sign_in_email, with: 'davethecat@katze.com'
        fill_in :sign_in_password, with: 'Bananaman'
        click_button 'Sign In'
        expect(page.current_path).to eq('/')
        expect(page).to have_content("Email or password is invalid")
      end
    end

    context 'Redirect' do
      scenario 'User cannot access any walls without signing in' do
        visit '/users/davethecat@katze.com'
        expect(page.current_path).to eq('/')
        expect(page).to have_content("Please sign in")
      end
    end
  end

  describe 'Sign out' do
    scenario 'User can sign out after signing in' do
      fill_in_sign_up_details
      click_button 'Sign Up'
      click_link 'Sign Out'
      visit '/'
      fill_in :sign_in_email, with: 'davethecat@katze.com'
      fill_in :sign_in_password, with: 'Gato123'
      click_button 'Sign In'
      click_on 'Sign Out'
      expect(page.current_path).to eq '/'
      expect(page).to have_content("You are now signed out")
    end

    scenario 'User can sign out after signing up' do
      fill_in_sign_up_details
      click_button 'Sign Up'
      click_on 'Sign Out'
      expect(page.current_path).to eq '/'
      expect(page).to have_content("You are now signed out")
    end
  end
end
