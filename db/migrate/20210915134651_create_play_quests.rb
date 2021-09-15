class CreatePlayQuests < ActiveRecord::Migration[6.1]
  def change
    create_table :play_quests do |t|
      t.integer :user_id
      t.integer :quest_id
      t.boolean :clear

      t.timestamps
    end
  end
end
