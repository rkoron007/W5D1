class Goal < ApplicationRecord
  validates :title, :user_id,:public, presence:true

  has_many :comments
  belongs_to :user
end
