class CreateMailContents < ActiveRecord::Migration[6.0]
  def change
    create_table :mail_contents do |t|
      t.integer :account_id
      t.string :message_id
      t.string :from
      t.string :to
      t.string :cc
      t.string :subject
      t.text :text_part
      t.text :html_part
      t.datetime :created_at
      t.boolean :is_multipart
      t.boolean :is_read
    end

    add_index :mail_contents, :account_id
    add_index :mail_contents, :message_id
    add_index :mail_contents, :created_at

    add_index :accounts, :last_checked_at
    add_index :accounts, :priority
    add_index :accounts, :email
  end
end
