class CreateMicroposts < ActiveRecord::Migration[6.1]
  def change
    create_table :microposts do |t|
      t.integer :time
      t.text :memo
      t.string :picture
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :microposts, %i[user_id created_at]
  end
end
