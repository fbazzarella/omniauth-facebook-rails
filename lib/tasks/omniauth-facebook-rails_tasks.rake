# desc "Explaining what the task does"
# task :omniauth-facebook-rails do
#   # Task goes here
# end
namespace :omniauth_facebook do
  desc "Copies required user migration"
  task setup: "omniauth_facebook_rails_engine:install:migrations" do
    puts "Please run rake db:migrate after this."
  end
end
