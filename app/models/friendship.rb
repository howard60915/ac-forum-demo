class Friendship < ApplicationRecord

	belongs_to :inviter , :class_name => 'User'
	belongs_to :accepter , :class_name => 'User'


end
