1. Copy the database sample to databaseyml
2. Fill in your info in database.yml
3. Run rake db:setup (does create and schema:load)
4. Register your app with soundcloud 
5. Copy application.yml.sample to application.yml with your soundcloud
   keys
6. You may want to setup something in /etc/hosts to look like the url
   you added to your soundcloud app (local.myapp.com:3000 could point to
127.0.0.1)
7. Profit!

-----------------
When a user auth's with soundcloud, the app will create a user with a
soundcloud identity, but will need an email address to be a valid
record.  You can mess around with validations on the user class if you
don't care about the email, as it's a little awkward.  
