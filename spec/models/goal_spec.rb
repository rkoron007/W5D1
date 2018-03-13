require 'rails_helper'

RSpec.describe Goal, type: :model do
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:public)}
  it { should validate_presence_of(:user_id)}

  it { should belong_to(:user) }
  it { should have_many(:comments) }
end
