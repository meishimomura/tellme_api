class CreateNotifySelves < ActiveRecord::Migration[6.1]
  def change
    create_table :notify_selves do |t|
      t.integer :notify_type
      t.boolean :notify_is_checked, default: false
      t.string     :to_uid, null: false
      t.string     :from_uid, null: false
      
      t.references :comment, foreign_key: true
      t.references :parent_comment

      t.timestamps
    end

    add_foreign_key :notify_selves, :users, column: :to_uid, primary_key: :uid
    add_foreign_key :notify_selves, :users, column: :from_uid, primary_key: :uid
    add_foreign_key :notify_selves, :comments, column: 'parent_comment_id'
  end
end
