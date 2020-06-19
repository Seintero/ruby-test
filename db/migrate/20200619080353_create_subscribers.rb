class CreateSubscribers < ActiveRecord::Migration[6.0]
  def change
    create_table :subscribers do |t|
      t.string :email,   :unique => true,  :null => false
      t.boolean :active, :default => true
      t.timestamps
    end
  end
end
