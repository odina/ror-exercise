# Initial admin user
user = User.new
user.is_admin = true
user.username = 'superuser'
user.email = 'admin@nowhere.com'
user.password = 'youshouldchangethis'
user.password_confirmation = 'youshouldchangethis'
user.save!

# Default questions

["What is your favorite book?",
 "Who is your favorite band?",
 "What is your favorite food?"].each do |question|
  q = Question.new
  q.question = question
  q.is_default = true
  q.save!
end
