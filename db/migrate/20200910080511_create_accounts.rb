class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :address, default: "outlook.office365.com"
      t.integer :port, default: 993
      t.string :email
      t.string :password
      t.boolean :enable_ssl, default: true
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
