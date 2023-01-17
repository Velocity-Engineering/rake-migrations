class CreateRakeMigrationsTable < ActiveRecord::Migration<%= @rails_major_minor_version %>
  def self.up
    create_table :rake_migrations do |t|
      t.string :version
      t.string :namespace
      t.string :task
      t.string :created_by
      t.datetime :created_at
      t.integer :duration
    end
  end

  def self.down
    drop_table :rake_migrations
  end
end
