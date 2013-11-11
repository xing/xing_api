Ruby client for the XING-API
============================

XingAPI is the offical ruby client for the [XING-API](https://dev.xing.com). It provides easy access to all API endpoints and simplifies response parsing, error handling and tries to ease the oauth pain.

Before you can start using the client, you need a [XING account](https://www.xing.com) and create an application in the [developer portal](https://dev.xing.com/applications) to have a consumer_key and consumer_secret.


Build status
------------



Installation
------------

```
gem install xing_api
```


Getting started
---------------

The simplest way to do the oauth handshake and request your own user profile:

```ruby
client = XingApi::Client.new consumer_key: "YOUR_CONSUMER_KEY", consumer_secret: "YOUR_CONSUMER_SECRET"
hash = client.get_request_token # => {:request_token=>"6479c262c06f4a002643", :request_token_secret=>"d7f5a128c01574e5bf10", :authorize_url=>"https://api.xing.com/v1/authorize?oauth_token=6479c262c06f4a002643"}
# open hash[:authorize_url] in your browser and authorize the access, remember the verifier for the next step!
client.get_access_token("YOUR_VERIFIER")
# ready to rock, but you have to supply the client instance with every call
XingApi::User.me(client: client)
```

If your know your oauth_token and oauth_token_secret already:

```ruby
XingApi::Client.configure do |config|
  config.consumer_key = "YOUR_CONSUMER_KEY"
  config.consumer_secret = "YOUR_CONSUMER_SECRET"
  config.oauth_token = "THE_USERS_OAUTH_TOKEN"
  config.oauth_token_secret = "THE_USERS_OAUTH_TOKEN_SECRET"
end
# ready to rock, no need for a client instance to pass around
XingApi::User.me
```


Integrating it in a rails app
-----------------------------

Outside of a console you problably want to use it a bit differently. So in a rails project for example, an initializer is a good place to put the consumer config:

```ruby
XingApi::Client.configure do |config|
  config.consumer_key = "YOUR_CONSUMER_KEY"
  config.consumer_secret = "YOUR_CONSUMER_SECRET"
end
```

And, assuming you did the handshake for your user already and saved the result of Client#get_access_token together with your users id, you just need to create a client instance with the saved token and secret:

```ruby
oauth_token, oauth_token_secret = # load from your db
client = XingApi::Client.new(oauth_token: oauth_token, oauth_token_secret: oauth_token_secret)

# ready to rock, there is no global token defined, so you have to supply the client instance
XingApi::User.me(client: client)
```

Or if you're code is executed single threaded anyway:

```ruby
oauth_token, oauth_token_secret = # load from your db
XingApi::Client.configure do |config|
  config.oauth_token = oauth_token
  config.oauth_token_secret = oauth_token_secret
end

# no client instance needed, because oauth token is set globally
XingApi::User.me
```


Authenticate the user (a.k.a. the oauth handshake) is also simple, but you need to store the request_token and secret (temporarily) and the access_token and secret permanently (this token might work up to ten years), there is no need to do the handshake every time.

At some point to need to start the process (assuming to configured the consumer_key and consumer_secret and your app is reachable via https://yoursite.com):

```ruby
XingApi::Client.new.get_request_token("https://yoursite.com/xing_callback")
>> {:request_token=>"647...", :request_token_secret=>"d7f...", :authorize_url=>"https://api.xing.com/v1/authorize?oauth_token=647..."}
```

You need to store the request_token and the request_token_secret in your database and then redirect the user to the authorize_url, the user will leave your site and authorize on the xing.com. On the user granted access to your consumer, XING will redirect him back to

```
https://yoursite.com/xing_callback?oauth_token=647...&oauth_verifier=12345
```

Your app needs to get the access token next:

```ruby
request_token, request_token_secret = # load from your db based on params[:oauth_token]
XingApi::Client.new.get_access_token(params[:oauth_verifer], request_token: request_token, request_token_secret: request_token_secret)
>> {:access_token=>"831...", :access_token_secret=>"d4a..."}
```

Store these in your database, and you're done.


Error handling
--------------

Every API call might fail for a bunch of different reasons, some are call specific others might happen for every call. Every error case has a unique name, which you can use for specific error handling:

```ruby
begin
  XingAPI::User.me(fields: 'id,display_name,foobar')
rescue XingApi::Error => e
  e.status_code # 403
  e.name        # "INVALID_PARAMETERS"
  e.text        # "Invalid parameters (Invalid user field(s) given: foobar)"
end
```

There are some errors which your app should handle in any case:

- XingApi::InvalidOauthTokenError (the token is not valid anymore, remove the entry from your db and start the handshake again)
- XingApi::RateLimitExceededError (your consumer did too many request, try again later)
- XingApi::ServerError (server side error)

Overview of all resources
-------------------------

The detailed documentation about each resource can be found here: [https://dev.xing.com/docs/resources](https://dev.xing.com/docs/resources)

Some of the provided calls are still in the [experimental](https://dev.xing.com/docs/call_life_cycle) state and can be used only with a test consumer. The full list of calls this client supports, is:

- `XingApi::Activity.delete(activity_id, options={})` [full documentation](https://dev.xing.com/docs/delete/activities/:id)
- `XingApi::Activity.find(activity_id, options={})` [full documentation](https://dev.xing.com/docs/get/activities/:id)
- `XingApi::Activity.share(activity_id, options={})` [full documentation](https://dev.xing.com/docs/post/activities/:id/share)
- `XingApi::Bookmark.create(user_id, options={})` [full documentation](https://dev.xing.com/docs/put/users/:user_id/bookmarks/:id)
- `XingApi::Bookmark.delete(user_id, options={})` [full documentation](https://dev.xing.com/docs/delete/users/:user_id/bookmarks/:id)
- `XingApi::Bookmark.list(options={})` [full documentation](https://dev.xing.com/docs/get/users/:user_id/bookmarks)
- `XingApi::Contact.list(user_id, options={})` [full documentation](https://dev.xing.com/docs/get/users/:user_id/contacts)
- `XingApi::Contact.shared(user_id, options={})` [full documentation](https://dev.xing.com/docs/get/users/:user_id/contacts/shared)
- `XingApi::ContactRequest.accept(user_id, options={})` [full documentation](https://dev.xing.com/docs/put/users/:user_id/contact_requests/:id/accept)
- `XingApi::ContactRequest.create(user_id, options={})` [full documentation](https://dev.xing.com/docs/post/users/:user_id/contact_requests)
- `XingApi::ContactRequest.deny(user_id, options={})` [full documentation](https://dev.xing.com/docs/delete/users/:user_id/contact_requests/:id)
- `XingApi::ContactRequest.list(options={})` [full documentation](https://dev.xing.com/docs/get/users/:user_id/contact_requests)
- `XingApi::ContactRequest.sent(options={})` [full documentation](https://dev.xing.com/docs/get/users/:user_id/contact_requests/sent)
- `XingApi::Conversation.create(recipient_ids, subject, content, options={})` [full documentation]()
- `XingApi::Conversation.delete(conversation_id, options={})` [full documentation](https://dev.xing.com/docs/delete/users/:user_id/conversations/:id)
- `XingApi::Conversation.find(conversation_id, options={})` [full documentation](https://dev.xing.com/docs/get/users/:user_id/conversations/:id)
- `XingApi::Conversation.invite(conversation_id, user_id, options={})` [full documentation](https://dev.xing.com/docs/put/users/:user_id/conversations/:conversation_id/participants/:id)
- `XingApi::Conversation.list(options={})` [full documentation](https://dev.xing.com/docs/get/users/:user_id/conversations)
- `XingApi::Conversation.read(conversation_id, options={})` [full documentation](https://dev.xing.com/docs/put/users/:user_id/conversations/:id/read)
- `XingApi::Conversation.valid_recipient(recipient_id, options={})` [full documentation](https://dev.xing.com/docs/get/users/me/conversations/valid_recipients/:id)
- `XingApi::GeoLocation.create(accuracy, latitude, longitude, options={})` [full documentation](https://dev.xing.com/docs/put/users/:user_id/geo_location)
- `XingApi::GeoLocation.nearby_users(options={})` [full documentation](https://dev.xing.com/docs/get/users/:user_id/nearby_users)
- `XingApi::Invite.create(emails, options={})` [full documentation](https://dev.xing.com/docs/post/users/invite)
- `XingApi::Job.find(job_id, options={})` [full documentation](https://dev.xing.com/docs/get/jobs/:id)
- `XingApi::Job.recommendations(options={})` [full documentation](https://dev.xing.com/docs/get/users/:user_id/jobs/recommendations)
- `XingApi::Job.search(query, options={})` [full documentation](https://dev.xing.com/docs/get/jobs/find)
- `XingApi::ProfileMessage.delete(options={})` [full documentation](https://dev.xing.com/docs/put/users/:user_id/profile_message)
- `XingApi::ProfileMessage.find(user_id, options={})` [full documentation](https://dev.xing.com/docs/get/users/:user_id/profile_message)
- `XingApi::ProfileMessage.update(message, options={})` [full documentation](https://dev.xing.com/docs/put/users/:user_id/profile_message)
- `XingApi::ProfileVisit.create(user_id, options={})` [full documentation](https://dev.xing.com/docs/post/users/:user_id/visits)
- `XingApi::ProfileVisit.list(options={})` [full documentation](https://dev.xing.com/docs/get/users/:user_id/visits)
- `XingApi::User.activities(user_id, options={})` [full documentation](https://dev.xing.com/docs/get/users/:id/feed)
- `XingApi::User.find(user_id, options={})` [full documentation](https://dev.xing.com/docs/get/users/:id)
- `XingApi::User.find_by_emails(emails, options={})` [full documentation](https://dev.xing.com/docs/get/users/find_by_emails)
- `XingApi::User.id_card(options={})` [full documentation](https://dev.xing.com/docs/get/users/me/id_card)
- `XingApi::User.me(options={})` [full documentation](https://dev.xing.com/docs/get/users/me)
- `XingApi::User.network_activities(options={})` [full documentation](https://dev.xing.com/docs/get/users/:user_id/network_feed)
- `XingApi::User.paths(user_id, options={})` [full documentation](https://dev.xing.com/docs/get/users/:user_id/network/:other_user_id/paths)
- `XingApi::User.shared(user_id, options={})` [full documentation](https://dev.xing.com/docs/get/users/:user_id/contacts/shared)
- `XingApi::User.status_message(message, options={})` [full documentation](https://dev.xing.com/docs/post/users/:id/status_message)

Contact
-------

If you have problems or feedback, feel free to contact us:

- XING-Developer-Group: [https://www.xing.com/net/xingdevs/](https://www.xing.com/net/xingdevs/)
- Mail: api-support@xing.com
- Twitter: @xingapi


If you want to contribute, just fork this project and send us a pull request.

Authors
-------

[Mark Schmidt](https://github.com/markschmidt) and [Johannes Strampe](https://github.com/johanness)

Please find out more about our work in our [dev blog](http://devblog.xing.com).


Copyright (c) 2013 [XING AG](http://www.xing.com/)

Released under the MIT license. For full details see LICENSE included in this distribution.
