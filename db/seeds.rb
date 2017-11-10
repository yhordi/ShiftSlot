require 'faker'
org = Organization.create(name: 'SoundGig Presents')
org.venues << Venue.create!(name: 'Victory Lounge', location: 'Seattle, WA')
org.venues << Venue.create!(name: 'Black Lodge', location: 'Seattle, WA')
org.venues << Venue.create!(name: 'Lucky Liquor', location: 'Tukwila, WA')
20.times do
  s = Show.new(doors: Faker::Date.forward)
  s.organization = org
  s.start = s.doors + 30.minutes
  s.show_end = s.doors + 4.hours
  s.venue_id = [1,2,3].sample
  s.headliner = Faker::RockBand.name
  s.info = Faker::Lorem.sentence
  s.save!
end
20.times do
  u = User.new(name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password)
  u.organizations << org
  u.save
end

Venue.all.each do |venue|
  Job.create(title: 'Security', venue: venue)
  Job.create(title: 'Bar', venue: venue)
  Job.create(title: 'Door', venue: venue)
  Job.create(title: 'Sound', venue: venue)
end

User.all.each { |user| user.jobs << Job.find(3)}

a = User.new(name: 'admin', email: 'admin@email.com', password: ENV['PASSWORD'])
a.save!
a.organizations << org
assignment = Assignment.find_by(user_id: a.id)
assignment.admin = true
a.save!
