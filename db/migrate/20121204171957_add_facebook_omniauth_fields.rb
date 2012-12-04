class AddFacebookOmniauthFields < ActiveRecord::Migration
  if User.table_exists?
    def self.up
      change_table :users do |t|
        create_user_fields_on(t)
      end
      add_email_index
    end

    def self.down
      # By default, we don't want to make any assumption about how to roll back a migration when your
      # model already existed. Please edit below which fields you would like to remove in this migration.
      raise ActiveRecord::IrreversibleMigration
    end
  else
    def change
      create_table :users do |t|
        create_user_fields_on(t)
        t.timestamps
      end
      add_email_index
    end
  end

  private
  def add_email_index
    add_index :users, :email
  end
  def create_user_fields_on(t)
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "photo_url"
    t.string   "access_token"
    t.string   "extra"
  end
end
