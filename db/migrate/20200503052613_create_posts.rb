class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :content, null: false
      t.string :subject, null: false
      t.references :user, foreign_key: true, null: false
    end
  end
end
