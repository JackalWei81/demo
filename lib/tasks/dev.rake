namespace :dev do

  task :rebuild => ["db:drop", "db:setup", :fake]

  task :ubike => :environment do

    url = "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=ddb80380-f1b3-4f8e-8016-7ed9cba571d5"

    json_string = RestClient.get(url)

    data = JSON.parse(json_string)

    data["result"]["results"].each do |u|
      existing = Ubike.find_by_raw_id(u["_id"])
      if existing
        #update
      else
        Ubike.create(:raw_id => u["_id"], :name =>u["sna"])
        puts "create #{u["sna"]}"
      end
    end

  end


  task :demo => :environment do
    puts "demo!!"

    puts Event.count
  end

  task :fake => :environment do
    User.delete_all
    Event.delete_all
    Attendee.delete_all

    puts "Creating fake data!!"

    user = User.create(:email => "jackal@gmail.com", :password => "123456789")

    50.times do |i|
      e = Event.create(:name => Faker::App.name)
      10.times do |j|
        e.attendees.create(:name => Faker::Name.name)
      end
    end
  end
end