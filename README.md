Ruby client for the XING-API [![Build Status](https://travis-ci.org/xing/xing_api.png?branch=master)](https://travis-ci.org/xing/xing_api)
============================

XingAPI is the offical ruby client for the [XING-API](https://dev.xing.com). It provides easy access to all API endpoints and simplifies response parsing, error handling and tries to ease the oauth pain.
Before you can start using the client, you need a [XING account](https://www.xing.com) and create an application in the [developer portal](https://dev.xing.com/applications) to have a consumer_key and consumer_secret.

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
# open hash[:authorize_url] in your browser and authorize the access, remember the verifier, request_token and request_token_secret for the next step!
client.get_access_token("YOUR_VERIFIER", request_token:  "YOUR_REQUEST_TOKEN", request_token_secret: "YOUR_REQUEST_TOKEN_SECRET")
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
XingApi::Client.new.get_access_token(params[:oauth_verifier], request_token: request_token, request_token_secret: request_token_secret)
>> {:access_token=>"831...", :access_token_secret=>"d4a..."}
```

Store these in your database, and you're done.

Error handling
--------------

Every API call might fail for a bunch of different reasons, some are call specific others might happen for every call. Every error case has a unique name, which you can use for specific error handling:

```ruby
begin
  XingApi::User.me(fields: 'id,display_name,foobar')
rescue XingApi::Error => e
  e.status_code # 403
  e.name        # "INVALID_PARAMETERS"
  e.text        # "Invalid parameters (Invalid user field(s) given: foobar)"
  e.errors      # [{ field: 'some_field', reason: 'SOME_REASON' }]
end
```

There are some errors which your app should handle in any case:
- XingApi::InvalidOauthTokenError (the token is not valid anymore, remove the entry from your db and start the handshake again)
- XingApi::RateLimitExceededError (your consumer did too many request, try again later)
- XingApi::ServerError (server side error)

Overview of all resources
-------------------------

#### Activities
- `XingApi::Activity.delete(activity_id, options = {})` ([docs](https://dev.xing.com/docs/delete/activities/:id))
- `XingApi::Activity.find(activity_id, options = {})` ([docs](https://dev.xing.com/docs/get/activities/:id))
- `XingApi::Activity.share(activity_id, options = {})` ([docs](https://dev.xing.com/docs/post/activities/:id/share))
- `XingApi::Activity::Comment.list(activity_id, options = {})` ([docs](https://dev.xing.com/docs/get/activities/:activity_id/comments))
- `XingApi::Activity::Comment.create(activity_id, comment, options = {})` ([docs](https://dev.xing.com/docs/post/activities/:activity_id/comments))
- `XingApi::Activity::Comment.delete(activity_id, comment_id, options = {})` ([docs](https://dev.xing.com/docs/delete/activities/:activity_id/comments/:id))
- `XingApi::Activity::Like.list(activity_id, options = {})` ([docs](https://dev.xing.com/docs/get/activities/:activity_id/likes))
- `XingApi::Activity::Like.create(activity_id, options = {})` ([docs](https://dev.xing.com/docs/put/activities/:activity_id/like))
- `XingApi::Activity::Like.delete(activity_id, options = {})` ([docs](https://dev.xing.com/docs/delete/activities/:activity_id/like))

#### Bookmarks
- `XingApi::Bookmark.create(user_id, options = {})` ([docs](https://dev.xing.com/docs/put/users/:user_id/bookmarks/:id))
- `XingApi::Bookmark.delete(user_id, options = {})` ([docs](https://dev.xing.com/docs/delete/users/:user_id/bookmarks/:id))
- `XingApi::Bookmark.list(options = {})` ([docs](https://dev.xing.com/docs/get/users/:user_id/bookmarks))

#### Contacts
- `XingApi::Contact.list(user_id, options = {})` ([docs](https://dev.xing.com/docs/get/users/:user_id/contacts))
- `XingApi::Contact.list_ids(options = {})` ([docs](https://dev.xing.com/docs/get/users/me/contact_ids))
- `XingApi::Contact.shared(user_id, options = {})` ([docs](https://dev.xing.com/docs/get/users/:user_id/contacts/shared))
- `XingApi::Contact::Tag.list(user_id, options = {})` ([docs](https://dev.xing.com/docs/get/users/:user_id/contacts/:contact_id/tags))
- `XingApi::ContactRequest.accept(user_id, options = {})` ([docs](https://dev.xing.com/docs/put/users/:user_id/contact_requests/:id/accept))
- `XingApi::ContactRequest.create(user_id, options = {})` ([docs](https://dev.xing.com/docs/post/users/:user_id/contact_requests))
- `XingApi::ContactRequest.deny(user_id, options = {})` ([docs](https://dev.xing.com/docs/delete/users/:user_id/contact_requests/:id))
- `XingApi::ContactRequest.list(options = {})` ([docs](https://dev.xing.com/docs/get/users/:user_id/contact_requests))
- `XingApi::ContactRequest.sent(options = {})` ([docs](https://dev.xing.com/docs/get/users/:user_id/contact_requests/sent))

#### Messages
- `XingApi::Conversation.create(recipient_ids, subject, content, options = {})` ([docs]())
- `XingApi::Conversation.delete(conversation_id, options = {})` ([docs](https://dev.xing.com/docs/delete/users/:user_id/conversations/:id))
- `XingApi::Conversation.find(conversation_id, options = {})` ([docs](https://dev.xing.com/docs/get/users/:user_id/conversations/:id))
- `XingApi::Conversation.list(options = {})` ([docs](https://dev.xing.com/docs/get/users/:user_id/conversations))
- `XingApi::Conversation.read(conversation_id, options = {})` ([docs](https://dev.xing.com/docs/put/users/:user_id/conversations/:id/read))
- `XingApi::Conversation.unread(conversation_id, options = {})` ([docs](https://dev.xing.com/docs/delete/users/:user_id/conversations/:id/read))
- `XingApi::Conversation.valid_recipient(recipient_id, options = {})` ([docs](https://dev.xing.com/docs/get/users/me/conversations/valid_recipients/:id))
- `XingApi::Conversation::Attachment.download_url(conversation_id, attachment_id, options = {})` ([docs](https://dev.xing.com/docs/post/users/me/conversations/:conversation_id/attachments/:id/download))
- `XingApi::Conversation::Attachment.list(conversation_id, options = {})` ([docs](https://dev.xing.com/docs/get/users/me/conversations/:conversation_id/attachments))
- `XingApi::Conversation::Message.create(conversation_id, content, options = {})` ([docs](https://dev.xing.com/docs/post/users/:user_id/conversations/:conversation_id/messages))
- `XingApi::Conversation::Message.find(conversation_id, message_id, options = {})` ([docs](https://dev.xing.com/docs/get/users/:user_id/conversations/:conversation_id/messages/:id))
- `XingApi::Conversation::Message.list(conversation_id, options = {})` ([docs](https://dev.xing.com/docs/get/users/:user_id/conversations/:conversation_id/messages))
- `XingApi::Conversation::Message.read(conversation_id, message_id, options = {})` ([docs](https://dev.xing.com/docs/put/users/:user_id/conversations/:conversation_id/messages/:id/read))
- `XingApi::Conversation::Message.unread(conversation_id, message_id, options = {})` ([docs](https://dev.xing.com/docs/delete/users/:user_id/conversations/:conversation_id/messages/:id/read))
- `XingApi::Invite.create(emails, options = {})` ([docs](https://dev.xing.com/docs/post/users/invite))

#### Groups
- `XingApi::Group.list(user_id, options = {})` ([docs](https://dev.xing.com/docs/get/users/:user_id/groups))
- `XingApi::Group.search(keywords, options = {})` ([docs](https://dev.xing.com/docs/get/groups/find))
- `XingApi::Group.read(group_id, options = {})` ([docs](https://dev.xing.com/docs/put/groups/:group_id/read))
- `XingApi::Group.join(group_id, options = {})` ([docs](https://dev.xing.com/docs/post/groups/:group_id/memberships))
- `XingApi::Group.leave(group_id, options = {})` ([docs](https://dev.xing.com/docs/delete/groups/:group_id/memberships))
- `XingApi::Group::Forum.list(group_id, options = {})` ([docs](https://dev.xing.com/docs/get/groups/:group_id/forums))
- `XingApi::Group::Forum::Post.create(forum_id, title, content, options = {})` ([docs](https://dev.xing.com/docs/post/groups/forums/:forum_id/posts))
- `XingApi::Group::Forum::Post.list(forum_id, options = {})` ([docs](https://dev.xing.com/docs/get/groups/forums/:forum_id/posts))
- `XingApi::Group::MediaPreview.create(url, options = {})` ([docs](https://dev.xing.com/docs/post/groups/media_previews))
- `XingApi::Group::Post.list(group_id, options = {})` ([docs](https://dev.xing.com/docs/get/groups/:group_id/posts))
- `XingApi::Group::Post.find(post_id, options = {})` ([docs](https://dev.xing.com/docs/get/groups/forums/posts/:post_id))
- `XingApi::Group::Post.delete(post_id, options = {})` ([docs](https://dev.xing.com/docs/delete/groups/forums/posts/:post_id))
- `XingApi::Group::Post::Comment.list(post_id, options = {})` ([docs](https://dev.xing.com/docs/get/groups/forums/posts/:post_id/comments))
- `XingApi::Group::Post::Comment.create(post_id, content, options = {})` ([docs](https://dev.xing.com/docs/post/groups/forums/posts/:post_id/comments))
- `XingApi::Group::Post::Comment.delete(comment_id, options = {})` ([docs](https://dev.xing.com/docs/delete/groups/forums/posts/comments/:comment_id))
- `XingApi::Group::Post::Comment::Like.list(comment_id, options = {})` ([docs](https://dev.xing.com/docs/get/groups/forums/posts/comments/:comment_id/likes))
- `XingApi::Group::Post::Comment::Like.create(comment_id, options = {})` ([docs](https://dev.xing.com/docs/put/groups/forums/posts/comments/:comment_id/like))
- `XingApi::Group::Post::Comment::Like.delete(comment_id, options = {})` ([docs](https://dev.xing.com/docs/delete/groups/forums/posts/comments/:comment_id/like))
- `XingApi::Group::Post::Like.list(post_id, options = {})` ([docs](https://dev.xing.com/docs/get/groups/forums/posts/:post_id/likes))
- `XingApi::Group::Post::Like.create(post_id, options = {})` ([docs](https://dev.xing.com/docs/put/groups/forums/posts/:post_id/like))
- `XingApi::Group::Post::Like.delete(post_id, options = {})` ([docs](https://dev.xing.com/docs/delete/groups/forums/posts/:post_id/like))

#### Jobs
- `XingApi::Job.find(job_id, options = {})` ([docs](https://dev.xing.com/docs/get/jobs/:id))
- `XingApi::Job.recommendations(options = {})` ([docs](https://dev.xing.com/docs/get/users/:user_id/jobs/recommendations))
- `XingApi::Job.search(query, options = {})` ([docs](https://dev.xing.com/docs/get/jobs/find))

#### News
- `XingApi::News::Article::Like.list(article_id, options = {})` ([docs](https://dev.xing.com/docs/get/news/articles/:article_id/likes))
- `XingApi::News::Article::Like.create(article_id, options = {})` ([docs](https://dev.xing.com/docs/put/news/articles/:id/like))
- `XingApi::News::Article::Like.delete(article_id, options = {})` ([docs](https://dev.xing.com/docs/delete/news/articles/:id/like))
- `XingApi::News::Article.find(article_id, options = {})` ([docs](https://dev.xing.com/docs/get/news/articles/:id))
- `XingApi::News::Article.update(article_id, version, options = {})` ([docs](https://dev.xing.com/docs/put/news/articles/:id))
- `XingApi::News::Article.delete(article_id, version, options = {})` ([docs](https://dev.xing.com/docs/delete/news/articles/:id))
- `XingApi::News::Page.find(page_id, options = {})` ([docs](https://dev.xing.com/docs/get/news/pages/:id))
- `XingApi::News::Page.list_editable(options = {})` ([docs](https://dev.xing.com/docs/get/users/me/news/pages/editable))
- `XingApi::News::Page.list_following(options = {})` ([docs](https://dev.xing.com/docs/get/users/me/news/pages/following))
- `XingApi::News::Page::Article.create(page_id, source_url, title, options = {})` ([docs](https://dev.xing.com/docs/post/news/pages/:page_id/articles))
- `XingApi::News::Page::Article.list(page_id, options = {})` ([docs](https://dev.xing.com/docs/get/news/pages/:page_id/articles))

#### Profile Messages
- `XingApi::ProfileMessage.delete(options = {})` ([docs](https://dev.xing.com/docs/put/users/:user_id/profile_message))
- `XingApi::ProfileMessage.find(user_id, options = {})` ([docs](https://dev.xing.com/docs/get/users/:user_id/profile_message))
- `XingApi::ProfileMessage.update(message, options = {})` ([docs](https://dev.xing.com/docs/put/users/:user_id/profile_message))

#### Visits
- `XingApi::ProfileVisit.create(user_id, options = {})` ([docs](https://dev.xing.com/docs/post/users/:user_id/visits))
- `XingApi::ProfileVisit.list(options = {})` ([docs](https://dev.xing.com/docs/get/users/:user_id/visits))

#### Users
- `XingApi::User.activities(user_id, options = {})` ([docs](https://dev.xing.com/docs/get/users/:id/feed))
- `XingApi::User.find(user_id, options = {})` ([docs](https://dev.xing.com/docs/get/users/:id))
- `XingApi::User.find_by_emails(emails, options = {})` ([docs](https://dev.xing.com/docs/get/users/find_by_emails))
- `XingApi::User.id_card(options = {})` ([docs](https://dev.xing.com/docs/get/users/me/id_card))
- `XingApi::User.me(options = {})` ([docs](https://dev.xing.com/docs/get/users/me))
- `XingApi::User.share_link(uri, options = {})` ([docs](https://dev.xing.com/docs/post/users/me/share/link))
- `XingApi::User.network_activities(options = {})` ([docs](https://dev.xing.com/docs/get/users/:user_id/network_feed))
- `XingApi::User.paths(user_id, options = {})` ([docs](https://dev.xing.com/docs/get/users/:user_id/network/:other_user_id/paths))
- `XingApi::User.search(keywords, options = {})` ([docs](https://dev.xing.com/docs/get/users/find))
- `XingApi::User.shared(user_id, options = {})` ([docs](https://dev.xing.com/docs/get/users/:user_id/contacts/shared))
- `XingApi::User.status_message(message, options = {})` ([docs](https://dev.xing.com/docs/post/users/:id/status_message))
- `XingApi::User.update(options = {})` ([docs](https://dev.xing.com/docs/put/users/me))
- `XingApi::User::BusinessAddress.update(options = {})` ([docs](https://dev.xing.com/docs/put/users/me/business_address))
- `XingApi::User::BirthDate.update(day, month, year, options = {})` ([docs](https://dev.xing.com/docs/put/users/me/birth_date))
- `XingApi::User::Company.create(name, title, industry, employment_type, options = {})` ([docs](https://dev.xing.com/docs/post/users/me/professional_experience/companies))
- `XingApi::User::Company.delete(company_id, options = {})` ([docs](https://dev.xing.com/docs/delete/users/me/professional_experience/companies/:id))
- `XingApi::User::Company.primary_company(company_id, options = {})` ([docs](https://dev.xing.com/docs/put/users/me/professional_experience/primary_company))
- `XingApi::User::Company.update(company_id, options = {})` ([docs](https://dev.xing.com/docs/put/users/me/professional_experience/companies/:id))
- `XingApi::User::Language.delete(language, options = {})` ([docs](https://dev.xing.com/docs/delete/users/me/languages/:language))
- `XingApi::User::Language.update(language, options = {})` ([docs](https://dev.xing.com/docs/put/users/me/languages/:language))
- `XingApi::User::Photo.delete(options = {})` ([docs](https://dev.xing.com/docs/delete/users/me/photo))
- `XingApi::User::Photo.update(body_hash, options = {})` ([docs](https://dev.xing.com/docs/put/users/me/photo))
- `XingApi::User::PrivateAddress.update(options = {})` ([docs](https://dev.xing.com/docs/put/users/me/private_address))
- `XingApi::User::Recommendation.delete(user_id, options = {})` ([docs](https://dev.xing.com/docs/delete/users/:user_id/network/recommendations/user/:id))
- `XingApi::User::Recommendation.list(options = {})` ([docs](https://dev.xing.com/docs/get/users/:user_id/network/recommendations))
- `XingApi::User::School.create(name, options = {})` ([docs](https://dev.xing.com/docs/post/users/me/educational_background/schools))
- `XingApi::User::School.delete(school_id, options = {})` ([docs](https://dev.xing.com/docs/delete/users/me/educational_background/schools/:id))
- `XingApi::User::School.update(school_id, options = {})` ([docs](https://dev.xing.com/docs/put/users/me/educational_background/schools/:id))
- `XingApi::User::School.primary_school(school_id, options = {})` ([docs](https://dev.xing.com/docs/put/users/me/educational_background/primary_school))
- `XingApi::User::Qualification.create(description, options = {})` ([docs](https://dev.xing.com/docs/post/users/me/educational_background/qualifications))
- `XingApi::User::WebProfile.delete(profile, options = {})` ([docs](https://dev.xing.com/docs/delete/users/me/web_profiles/:profile))

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

Copyright (c) 2016 [XING AG](http://www.xing.com/)

Released under the MIT license. For full details see LICENSE included in this distribution.
