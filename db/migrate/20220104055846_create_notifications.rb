class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.string     :uid, null: false
      t.references :group, null: false, foreign_key: true
      t.string     :notification_title
      t.text :notification_content

      t.timestamps
    end

    add_foreign_key :notifications, :users, column: :uid, primary_key: :uid
  end
end
