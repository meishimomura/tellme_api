class CreateNotificationChecks < ActiveRecord::Migration[6.1]
  def change
    create_table :notification_checks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :notification, null: false, foreign_key: true

      t.timestamps
    end
  end
end
