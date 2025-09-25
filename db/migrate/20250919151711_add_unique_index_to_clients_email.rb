class AddUniqueIndexToClientsEmail < ActiveRecord::Migration[8.0]
  def change
    add_index :clients, :email, unique: true
  end
end
