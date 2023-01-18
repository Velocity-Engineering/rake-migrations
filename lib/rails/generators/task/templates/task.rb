# Checklist:
# - Should this be inside a Active Record Transaction block?
# - Do we need to notify specific stakeholders about the database changes?
# - Any callbacks, emails or notifications triggered?
# - Appropriate prints and progress logs?
# - Performance issues and manual garbage collection required?

namespace :<%= file_name %> do
<% actions.each do |action| -%>
  desc "TODO"
  task <%= action %>: [:environment] do
    time = Benchmark.realtime {
      ActiveRecord::Base.transaction do
        # ADD YOUR CODE HERE

      end
    }
    # DO NOT REMOVE THIS PART. MARKS THE RAKE AS COMPLETE IN THE DATABASE
    top_level_task = Rake.application.top_level_tasks[0]
    RakeMigration.mark_complete(__FILE__, top_level_task.split(':')[0], top_level_task.split(':')[1], 'System', time)
  end
<% end -%>
end
