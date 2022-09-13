class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :username, null: false, uniqueness: true
      t.string :password_digest, null: false, uniqueness: true
      t.string :session_token, uniqueness: true
      t.string :email, null: false, uniqueness: true
      t.string :company_name

      t.timestamps

      t.index :username
      t.index :email
    end
  end
end
