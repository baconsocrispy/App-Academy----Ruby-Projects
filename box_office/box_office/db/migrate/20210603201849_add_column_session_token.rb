class AddColumnSessionToken < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :session_token, :string, uniqueness: true
  end
end
