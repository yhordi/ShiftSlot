require 'faker'
org = Organization.create(name: 'SoundGig Presents')
org.venues << Venue.create!(name: 'Victory Lounge', location: 'Seattle, WA', hooks: 'Vic')
org.venues << Venue.create!(name: 'Black Lodge', location: 'Seattle, WA', hooks: 'BL')

black_lodge = Venue.find_by(name: 'Black Lodge')
victory_lounge = Venue.find_by(name: 'Victory Lounge')

Job.create(title: 'volunteer', venue: black_lodge)
Job.create(title: 'door', venue: black_lodge)
Job.create(title: 'sound', venue: black_lodge)
Job.create(title: 'sound', venue: victory_lounge)
Job.create(title: 'door', venue: victory_lounge)

a = User.new(name: 'Jordan Kamin', email: 'jordanakamin@gmail.com', password: ENV['PASSWORD'])
a.save!
a.organizations << org
assignment = Assignment.find_by(user_id: a.id)
assignment.admin = true
assignment.save
a.save!
