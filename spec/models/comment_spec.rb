require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should validate_presence_of(:message) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:post_id) }
end
