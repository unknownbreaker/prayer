100.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  User.create(username: Faker::Internet.user_name("#{first_name} #{last_name}", %w(. _ -)), password: "asdf", first_name: first_name, last_name: last_name, email: Faker::Internet.email(first_name), country: Faker::Address.country)
end

30.times do
  user = User.all.sample
  user.prayerrequests.create(prayerrequest: Faker::Lorem.sentence(3))
end


50.times do
  request = Prayerrequest.all.sample
  request.comments.create(comment: Faker::Lorem.sentence(3), user_id: User.all.sample.id)
end
