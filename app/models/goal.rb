class Goal < ActiveRecord::Base
  validates :description, :user, presence: true

  belongs_to :user
end
