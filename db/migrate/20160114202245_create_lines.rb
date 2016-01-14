class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.string :text
      t.integer :number
      t.references :document, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
