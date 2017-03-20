# Rails Boilerplate

The reason behind for this repository is that many times we found ourselves, as
developers, repeating over and over again the very same setup processes when
starting new applications.

This is generic repository, containing the bases for an application and which
main purpose is to serve as a template/boilerplate for applications that share
a given set of technologies.

After kicking-off many projects, we found that there is a trend and that many
applications make use of 5 mainstream technologies:
* Ruby on Rails, a full-stack MVC web-application framework
* Devise, an authentication solution for Rails based on Warden
* RailsAdmin, an administration framework for Ruby on Rails applications
* S3, an object storage service with a simple web service interface
* Stripe, online payments service with a neat and developer-friendly API

Below is a quick guide on how to use this repository as a boilerplate for a new
application that relies on the above stated technology stack.

## Devise

#### Configuration
1. Ensure you have defined default url options in production environment file. Here
   is an example of `default_url_options` appropriate for a production environment
   in config/environments/production.rb:
   ```ruby
   config.action_mailer.default_url_options = { host: <HOST>, port: 3000 }
   ```

   **HOST** should be set to the actual host of your application.

2. You can copy Devise views (for customization) to your app by running:
   ```
   rails g devise:views
   ```

#### Usage
In the following command you will replace `MODEL` with the class name used for
the application’s users (it’s frequently User but could also be Admin). This
will create a model (if one does not exist) and configure it with the default
Devise modules.

```
rails generate devise MODEL
```

## RailsAdmin

#### Configuration + Devise
You must change the namespace /admin in the `routes` file to that you want.

```ruby
mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
```

Also in `config/initializers/rails_admin.rb` you need to change under the
**Devise** title the `scope: :admin` and `:current_admin` by the one you
selected before.

e.g:
```ruby
config.authenticate_with do
  warden.authenticate! scope: :user
end
config.current_user_method(&:current_user)
```

## S3 + Paperclip

#### Configuration
You can find in the production and development files in config/environments/
the following setup:

```ruby
config.paperclip_defaults = {
  storage: :s3,
  url: ':s3_domain_url',
  path: '/:class/:attachment/:id_partition/:style/:filename',
  s3_credentials: {
    bucket: ENV.fetch('S3_BUCKET_NAME_PROD'),
    access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID'),
    secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
    s3_region: ENV.fetch('AWS_REGION'),
  }
}
```

then you need to create a file `application.yml` in config/ directory with the
credentials, you can find a sample file called `application.yml.example`.

Finally to add attachment functionality to a `MODEL` use the *Paperclip* helper
method `has_attached_file` and a symbol with the desired name of the attachment.

e.g:
```ruby
class Friend < ActiveRecord::Base
  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
```

**Important**
Don't forget run the migration for the attached name (:avatar in the example),
update the *form* that allows users to browse and select images from their
local filesystem (make sure the form has `multipart: true` added to it).
Also you need to specify the permitted params (:avatar in this case).

To show the image you need to add the following line in the view you want:

```ruby
# Using the same example as before
<%= image_tag @friend.avatar.url(:square) %>
```

## Stripe

coming soon...
