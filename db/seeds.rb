User.create!(
  name: 'Example User',
  email: 'example@railstutorial.org',
  password: 'foobar',
  password_confirmation: 'foobar',
  activated: true
)

5.times do |n|
  name = Faker::Name.name
  email = "example_#{n + 1}@railstutorial.org"
  password = 'password'
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    activated: true
  )
end

users = User.order(:created_at).take(3)
50.times do
  memo = Faker::Lorem.sentence(word_count: 6)
  users.each { |user| user.microposts.create!(memo: memo) }
end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
