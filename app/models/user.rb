class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :groups #使用者邁立的討論群
  has_many :posts

  has_many :group_relationships
  has_many :joined_groups, through: :group_relationships, source: :group  #使用者加入的討論群

  def is_member_of?(group)
	  joined_groups.include?(group)
	end
end
