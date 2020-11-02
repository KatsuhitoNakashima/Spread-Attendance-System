class AddHourpayToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :hourpay, :integer
  end
end
