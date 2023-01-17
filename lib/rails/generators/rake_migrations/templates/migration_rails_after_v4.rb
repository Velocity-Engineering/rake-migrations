class CreateRakeMigrationsTable < ActiveRecord::Migration<%= @rails_major_minor_version %>
  def self.up
    create_table :rake_migrations do |t|
      t.string :version
      t.string :uuid, null: false, unique: true
      t.string :payee_id
      t.string :bank_partner_id
      t.string :account_number
      t.string :account_type
      t.string :ifsc_code
    end
  end

  def self.down
    drop_table :rake_migrations
  end
end
