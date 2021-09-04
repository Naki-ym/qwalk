class CreateSpots < ActiveRecord::Migration[6.1]
  def change
    create_table :spots do |t|
      t.integer :quest_id
      t.text :q_text
      t.string :answer
      t.text :a_text

      t.timestamps
    end
  end
end
