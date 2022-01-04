class CreateNotificationChecks < ActiveRecord::Migration[6.1]
  def change
    create_table :notification_checks do |t|
      t.string     :uid, null: false
      t.references :notification, null: false, foreign_key: true

      t.timestamps
    end
    
    add_foreign_key :notification_checks, :users, column: :uid, primary_key: :uid
  end
end
