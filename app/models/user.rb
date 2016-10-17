class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  scope :all_except, ->(user) { where.not(id: user) }

  has_many :friendships, ->{ where(:status => "accepted")}, :class_name => "Friendship", :foreign_key => "inviter_id"
  has_many :added_friendships, ->{ where(:status => "added")}, :class_name => "Friendship", :foreign_key => "inviter_id"
  has_many :pending_friendships, ->{ where(:status => "pending")}, :class_name => "Friendship", :foreign_key => "inviter_id"


  has_many :events


  include Gravtastic
  gravtastic :size => 30, :default => 'retro'
  

  def short_name
	self.email.split("@").first        	
  end       

  def admin?
  	self.role == "admin"
  end

   def self.from_omniauth(auth)
     # Case 1: Find existing user by facebook uid
     user = User.find_by_fb_uid( auth.uid )
     if user
        user.fb_token = auth.credentials.token
        #user.fb_raw_data = auth
        user.save!
       return user
     end

     # Case 2: Find existing user by email
     existing_user = User.find_by_email( auth.info.email )
     if existing_user
       existing_user.fb_uid = auth.uid
       existing_user.fb_token = auth.credentials.token
       #existing_user.fb_raw_data = auth
       existing_user.save!
       return existing_user
     end

     # Case 3: Create new password
     user = User.new
     user.fb_uid = auth.uid
     user.fb_token = auth.credentials.token
     user.email = auth.info.email
     user.password = Devise.friendly_token[0,20]
     #user.fb_raw_data = auth
     user.save!
     return user
   end

end
