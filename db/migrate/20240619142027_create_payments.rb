class CreatePayments < ActiveRecord::Migration[7.2]
  def change
    create_table :payments do |t|
      t.string :email
      t.string :token
      t.integer :user_id

      t.timestamps
    end
  end
end
