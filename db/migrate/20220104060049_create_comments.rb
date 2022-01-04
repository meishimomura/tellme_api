class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :subject, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :parent_comment
      t.text :comment_content
      t.boolean :comment_is_checked

      t.timestamps
    end

    add_foreign_key :comments, :comments, column: 'parent_comment_id'
  end
end
