class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :city
      t.string :title
      t.text :description
      t.string :location
      t.string :link
      t.datetime :event_date
      t.string :image
      t.timestamps
    end
  end
end
