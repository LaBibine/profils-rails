class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :address
      t.integer :phone
      t.string :email

      t.timestamps
    end
  end
end
