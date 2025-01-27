Rake Migrations
===============

This gem helps you and your team members keep track of which rake tasks are yet to be run on a particular system. The logic is similar to that of how `rake db:migrate` is used.

For a more verbose explanation please refer to [this blog post](http://eyaleizenberg.blogspot.com/2014/08/how-to-keep-track-of-rails-rake-tasks.html).

## Requirements
At the moment I have only tested this on Rails 5.X.X, 6.X.x and 7.X.X  running postgresql on Mac OS X.
If you can help by testing this on different versions, databases and platforms, let me know.

## Installation
First, add this this to your gemfile:
```ruby
gem 'rake_migrations', git: 'https://github.com/Velocity-Engineering/rake-migrations.git'
```

Then, run:
```sh
bundle install


rails g rake_migrations:install

# Don't forget to migrate
rake db:migrate
```

This will copy a db schema migration (`rake_migrations`) file and a helper rake task (`devops_rake_utils.rake`) in your `lib/tasks/` directory

Finally, add the following file in your `config/initializers` folder to provide the gem with database credentials via the `database.yml` file
```ruby
# rake_migrations.rb
RakeMigrations.configure do |config|
  config.database_name = 'neobank'
  config.hostname = ENV['DATABASE_HOST']
  config.username = ENV['DATABASE_USERNAME']
  config.password = ENV['DATABASE_PASSWORD']
end
```

## Usage
Whenever somebody from your team wants to create a new run once task, simply generate it by running:

```sh
rails g task <namespace> <task>
```

For example:

```sh
rails g task migrations_test testing_the_gem
```

This will generate a file under `lib/tasks/rake_migrations` with a timestamp and six random character prefixed filename and the following content:

```ruby
# 
  
# Checklist:
# 1. Re-runnable on production?
# 2. Is there a chance emails will be sent?
# 3. puts ids & logs (progress log)
# 4. Should this be inside a Active Record Transaction block?
# 5. Are there any callbacks?
# 6. Performance issues?

namespace :migrations_test do
  desc "TODO"
  task testing_the_gem: [:environment] do

    # DO NOT REMOVE THIS PART. MARKS THE RAKE AS COMPLETE IN THE DATABASE
    RakeMigration.mark_complete(__FILE__)
  end
end

```

Simply insert your code above the "DO NOT REMOVE THIS PART" line. The checklist is there to help you and the person who is code-reviewing your code to think of problems that might occur from your rake task.

Afterwards, whenever we need to check whether pending rake tasks, we run the following helper rake task...

```sh
rake devops_rake_utils:list_pending_rake_tasks
```

... which will give the following output in case some tasks aren't mapped to the `rake_migrations` database table

```sh
You need to run the following rakes:
------------------------------------
rake migrations_test:testing_the_gem
```

You can run the rake task normally:

```sh
rake migrations_test:testing_the_gem
```

In case all of the rake files have been mapped across the `rake_migrations` table, you will receive the following message

```sh
All rake files are mapped in the DB! No untracked rake tasks are present!
```

## Caveats
- In order to make sure the gem is serving the intended purpose, please make sure every rake file has just one namespace and one task only
- Adding support for multiple tasks beneath a single name space in a single rake file might a feature request we may consider in the future

## Issues, suggestions and forks.
Feel free to open issues, send suggestions and fork this repository.

This gem was developed by [Eyal Eizenberg](http://eyaleizenberg.blogspot.com/2014/08/how-to-keep-track-of-rails-rake-tasks.html) and enhanced by [Mani Bhushan](https://github.com/manibhushan05/).

Thanks and Enjoy! :)
