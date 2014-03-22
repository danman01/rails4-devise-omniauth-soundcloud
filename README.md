## Nine Thousand Simple Steps to get up and running:
1. Copy the database.yml.sample to database.yml
2. Fill in your info in database.yml
3. Run rake db:setup (does create and schema:load)
4. `cp .gitignore-sample .gitignore` and make sure everything is
ignored that you want
5. Register your app with soundcloud 
6. Copy application.yml.sample to application.yml with your soundcloud
   keys
7. You may want to setup something in /etc/hosts to look like the url
   you added to your soundcloud app (local.myapp.com:3000 could point to
127.0.0.1). I don't think this is needed actually...You do want to set
the callback url to something like this:
`http://localhost:3000/users/auth/soundcloud/callback` within your
soundcloud app settings
8. Give your app an awesome name instead of MyApp (maybe something like
   MyMusicApp?)
9. Profit!

-----------------
When a user auth's with soundcloud, the app will create a user with a
soundcloud identity, but will need an email address to be a valid
record.  You can mess around with validations on the user class if you
don't care about the email, as it's a little awkward.  

There are a few tests available if you want to run those. Do `rake
db:test:prepare` and then `rspec spec/models/* --format documentation`
