namespace :dev do
  desc "update Ubike data"
  task ubike: :environment do
      url = "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=ddb80380-f1b3-4f8e-8016-7ed9cba571d5"
      response = RestClient.get(url)
      raw_data = JSON.parse(response)
      raw_data["result"]["results"].each do |u|
        existing_data = UbikeStation.find_by_iid(u["iid"])
        if existing_data
          puts "Update #{existing_data.iid} ubike"
          existing_data.update(
            :roadmark => u["sna"],
            :area => u["sarea"],
            :number_of_bike => u["sbi"]
          )
        else 
          puts "Create #{u["iid"]} ubike"
          UbikeStation.create(
            :iid => u["iid"],
            :roadmark => u["sna"],
            :area => u["sarea"],
            :number_of_bike => u["sbi"]
          ) 
        end 
      end  
  end

end




  # task :rebuild => ["db:reset" , :fake]
  # task fake: :environment do
  #     Category.create(:name => "Flame")
  #     Category.create(:name => "Aqua")
  #     Category.create(:name => "Ghost")
  #     20.times do
  #     @event = Event.create(:name => Faker::Name.name , :description => Faker::Hipster.paragraph)
  #     puts "create event id is #{@event.id}"
  #       (5..10).to_a.sample.times do
  #         attendee = @event.attendees.create(:name => Faker::Pokemon.name)
  #         puts "create attendee id is #{attendee.id}"
  #       end
  #     end
  # end