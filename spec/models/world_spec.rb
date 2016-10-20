require 'rails_helper' #要執行rspec需要使用此helper，但是全部執行

describe "Hello" do 

	before { @z = 2 }

	it "Hi" do
		y = @z + 1 
		expect(y).to eq(3)
		x = y + 1
		expect(x).to eq(3)

	end	
	# it "yo" do
	# 	expect(2 + 3 ).to be >6
	# end 
	it "change" do 
		user = User.new(email: 'xxx@gmail.com' , password: "123456")
		expect{
			user.save
			}.to change{User.count}
 	end 
 	it "change2" do 
 		topic = Event.create(name: "123")
 		expect{
 			topic.update(name: "231")
 		}.to change{ topic.reload.name }
 	end	
 	it "change3" do 
 		topic = Event.create(name: "123")
 		topic_name = topic.reload.name
 		topic.update(name: "3121")
 		expect(topic_name).to eq(topic.reload.name)
 	end	#跟change2的結果一樣
end	