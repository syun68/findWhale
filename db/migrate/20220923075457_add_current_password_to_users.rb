class AddCurrentPasswordToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :current_password, :string
  end
end
