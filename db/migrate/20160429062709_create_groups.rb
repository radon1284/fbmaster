class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.references :user, index: true
      t.string :gid
      t.string :name
      t.string :creator
      t.text :description
      t.string :privacy
      t.string :website
      t.string :email
      t.string :icon50
      t.string :icon

      t.timestamps
    end
  end
end
