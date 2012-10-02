class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :name
      t.text :category
      t.date :date
      t.time :time
      t.text :place

      t.timestamps
    end
  end
end
