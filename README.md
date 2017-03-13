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

2. Ensure you have defined `root_url` to *something* in your config/routes.rb.
   For example:
   ```ruby
   root to: "home#index"
   ```

3. You can copy Devise views (for customization) to your app by running:
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
