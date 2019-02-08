require 'rails_helper'

class UserTest < ActiveSupport::TestCase
  RSpec.describe User, type: :model do
    it { should validate_presence_of(:first_name).with_message("Meow, what is your a first name?") }
    it { should validate_presence_of(:last_name).with_message("Meow, what is your last name?") }
    it { should validate_presence_of(:email).with_message("Meow, what is your email?") }
    it { should validate_presence_of(:password).with_message("Meow, what is your password?") }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_length_of(:password).is_at_most(10) }
    it { should have_secure_password }
    it { should validate_presence_of(:gender).with_message("Meow, what is your gender?") }
    it { should validate_presence_of(:birthday).with_message("Meow, when is your birthday?") }
  end
end
