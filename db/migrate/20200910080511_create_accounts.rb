class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :address, default: "outlook.office365.com"
      t.integer :port, default: 993
      t.string :email
      t.string :password
      t.boolean :enable_ssl, default: true
    end
  end
end
