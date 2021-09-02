class CreateQuests < ActiveRecord::Migration[6.1]
  def change
    create_table :quests do |t|
      t.text :title
      t.text :caption

      t.timestamps
    end
  end
end
