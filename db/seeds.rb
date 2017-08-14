Venue.create!(name: 'Victory Lounge', location: 'Seattle, WA')
Venue.create!(name: 'Black Lodge', location: 'Seattle, WA')
Venue.create!(name: 'Lucky Liquor', location: 'Tukwila, WA')
20.times do
  s = Show.new(doors: Faker::Date.forward)
  s.start = s.doors + 30.minutes
  s.show_end = s.doors + 4.hours
  s.venue_id = [1,2,3].sample
  s.save!
end
20.times do
  User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password)
end
Job.create(title: 'Security')
Job.create(title: 'Bar')
Job.create(title: 'Door')
Job.create(title: 'Sound')
Venue.all.each do |venue|
  Job.all.each do |job|
    venue.jobs << job
  end
end
Venue.find(2).jobs.delete(Job.find(2))
User.all.each { |user| user.jobs << Job.find(3)}
days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
days.each do |day|
  PreferredDay.create(name: day)
end

User.create(name: 'admin', admin: true, email: 'admin@email.com', password: ENV['PASSWORD'])
