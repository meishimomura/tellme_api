class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :subject, null: false, foreign_key: true
      t.string     :uid, null: false
      t.references :parent_comment
      t.text :comment_content
      t.boolean :comment_is_settled, default: false
      t.string  :comment_image_path
      t.text :comment_image_text
      

      t.timestamps
    end

    add_foreign_key :comments, :comments, column: 'parent_comment_id'
    add_foreign_key :comments, :users, column: :uid, primary_key: :uid
  end
end
