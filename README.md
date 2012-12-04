##omniauth-facebook-rails
This gem speeds up omniauth-facebook setup in Rails apps.

##Getting started
omniauth-facebook-rails works with Rails 3.2 onwards. You can add it to your Gemfile with:

```ruby
gem 'omniauth-facebook-rails'
```

Add the required environment variables:

```
export FACEBOOK_APP_KEY=123456
export FACEBOOK_APP_SECRET=abcdef
```

It is heavily recommended for you to change railsties order in
`config/application.rb`:

```ruby
config.railties_order = [OmniauthFacebookRails::Engine, :main_app, :all]
```

Otherwise, your `User` model won't load the Engine's  `User` model.

##Features/Problems
* It is in Portuguese.
* You only are granted access to the person's  email.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License
This project is released under the [MIT
License](http://www.opensource.org/licenses/MIT)
