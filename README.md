# Rails Boilerplate

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

## S3

#### Configuration
You can find in the production and development files in config/environments/
the following setup:

```ruby
config.paperclip_defaults = {
  storage: :s3,
  s3_credentials: {
    bucket: ENV["S3_BUCKET_NAME_PROD"],
    access_key_id: ENV["AWS_ACCESS_KEY_ID"],
    secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
    s3_region: ENV["AWS_REGION"],
  }
}
```

then you need to create a file `application.yml` in config/ directory with the
credentials, you can find a sample file called `application.yml.example`.
