# Video Call 

>We have used Opentok gem for video calling. One user can do the video call with >other users.
>User can create their own meetings and select the users for that meeting and >then a meeting url is generated which user can share with selected users and >then only selected users can join the meeting through that url after login >their account.
Reference- https://github.com/opentok/OpenTok-Ruby-SDK

# Setup

      -Ruby - 2.6.5 
      -Rails 5.2.3
      -Postgresql - 9.5.19
      -bundle install
      -rake db:create
      -rake db:migrate 
      -rake db:seed


You need to add Gems in gemfile:
- gem 'devise'
- gem 'opentok', '~> 2.3'


# User credentials
* User 1: email- "email1@email.com"
        password: "password"
* User 2:  email- "email2@email.com"
        password: "password"

# User signup

<div align="center">
    <img src="/app/assets/images/meeting_signup.png" width="400px"</img> 
</div>

# User Login

<div align="center">
    <img src="/app/assets/images/login_ss.png" width="400px"</img> 
</div>

# New meeting creation

<div align="center">
    <img src="/app/assets/images/new_meeting_ss.png" width="400px"</img> 
</div>

# Meeting lists

<div align="center">
    <img src="/app/assets/images/meeting_list_ss.png" width="400px"</img> 
</div>


# Meeting confrence(Publisher)

<div align="center">
    <img src="/app/assets/images/meeting_call_a.png" width="400px"</img> 
</div>

# Meeting confrence(Subscriber)

<div align="center">
    <img src="/app/assets/images/meeting_call_b.png" width="400px"</img> 
</div>
