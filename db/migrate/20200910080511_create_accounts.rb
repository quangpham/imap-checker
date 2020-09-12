class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :email
      t.string :password
      t.datetime :last_checked_at
      t.integer :unread_count
      t.string :error
      t.string :heroku_app_name
      t.integer :priority
    end

    add_index :accounts, :last_checked_at
    add_index :accounts, :priority
    add_index :accounts, :email
    
  end
end
