# Initial admin user
user = User.new
user.is_admin = true
user.username = 'superuser'
user.email = 'admin@nowhere.com'
user.password = 'youshouldchangethis'
user.password_confirmation = 'youshouldchangethis'
user.save!
