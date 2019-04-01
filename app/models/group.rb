class Group < ApplicationRecord
	
	belongs_to :user
	has_many :posts, dependent: :destroy

	validates :title, presence: true

	has_many :group_relationships, dependent: :destroy
	has_many :members, through: :group_relationships, source: :user

	
end
