class AddImageNameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :image_name, :string
  end
end
