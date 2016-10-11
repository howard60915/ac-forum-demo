class Event < ApplicationRecord
	validates_presence_of :name
	has_many :attendees
	belongs_to :category
	belongs_to :user
	
	delegate :name, :to => :category , :prefix => true, :allow_nil => true
	
	has_many :event_groupships #實際包含為 has_many :event_groupships, :class_name => "EventGroupships", :foreign_key => "event_id"
	has_many :groups, :through => :event_groupships

	has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
 	validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

end
