class AddBikouToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :bikou, :string
  end
end
