class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :subject, null: false, foreign_key: true
      t.string     :uid, null: false
      t.references :parent_comment
      t.text :comment_content
      t.boolean :comment_is_checked, null: false, default: false

      t.timestamps
    end

    add_foreign_key :comments, :comments, column: 'parent_comment_id'
    add_foreign_key :comments, :users, column: :uid, primary_key: :uid
  end
end
