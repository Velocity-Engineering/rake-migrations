class CreateRakeMigrationsTable < ActiveRecord::Migration<%= @rails_major_minor_version %>
  def self.up
    create_table :rake_migrations do |t|
      t.string :version
      t.string :namespace
      t.string :task_name
      t.string :created_by
      t.datetime :created_at
      t.float :duration
    end
  end

  def self.down
    drop_table :rake_migrations
  end
end
