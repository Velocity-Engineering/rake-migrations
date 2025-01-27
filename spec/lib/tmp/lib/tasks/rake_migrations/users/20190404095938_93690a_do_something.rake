# Checklist:
# - Should this be inside a Active Record Transaction block?
# - Do we need to notify specific stakeholders about the database changes?
# - Any callbacks, emails or notifications triggered?
# - Appropriate prints and progress logs?
# - Performance issues and manual garbage collection required?

namespace :users do
  desc "TODO"
  task do_something: [:environment] do
    ActiveRecord::Base.transaction do
      # ADD YOUR CODE HERE

    end

    # DO NOT REMOVE THIS PART. MARKS THE RAKE AS COMPLETE IN THE DATABASE
    RakeMigration.mark_complete(__FILE__, namespace, task_name, created_by, duration )

  end
end
