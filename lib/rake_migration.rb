class RakeMigration < ::ActiveRecord::Base
  def self.version_from_path(path)
    path.split('/').last.split('_').first(2).join('_')
  end

  def self.findcreate_by_version(rake_id, namespace, task_name, created_by, duration)
    find_or_create_by(
      version: rake_id, namespace: namespace, task_name: task_name, created_by: created_by, duration: duration, created_at: Time.now.utc.in_time_zone('Asia/Kolkata'))
  end

  def self.mark_complete(file, namespace, task_name, created_by, duration)
    rake_id = version_from_path(file)
    if methods.include?(:find_or_create_by)
      find_or_create_by(
        version: rake_id, namespace: namespace, task_name: task_name, created_by: created_by, duration: duration, created_at: Time.now.utc.in_time_zone('Asia/Kolkata'))
    else
      findcreate_by_version(rake_id, namespace, task_name, created_by, duration)
    end
  end

  def self.check_for_pending_tasks
    RakeMigrations.check
  end

end
