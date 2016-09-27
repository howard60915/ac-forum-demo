namespace :dev do
  desc "TODO"
  task :rebuild => ["db:reset" , :fake]
  task fake: :environment do
      Category.create(:name => "Flame")
      Category.create(:name => "Aqua")
      Category.create(:name => "Ghost")
  	  20.times do
      @event = Event.create(:name => Faker::Name.name , :description => Faker::Hipster.paragraph)
      puts "create event id is #{@event.id}"
        (5..10).to_a.sample.times do
          attendee = @event.attendees.create(:name => Faker::Pokemon.name)
          puts "create attendee id is #{attendee.id}"
        end
      end
  end

end
