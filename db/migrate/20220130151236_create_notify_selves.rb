class CreateNotifySelves < ActiveRecord::Migration[6.1]
  def change
    create_table :notify_selves do |t|
      t.integer :notify_type
      t.string     :to_uid, null: false
      t.string     :from_uid, null: false

      t.timestamps
    end

    add_foreign_key :notify_selves, :users, column: :to_uid, primary_key: :uid
    add_foreign_key :notify_selves, :users, column: :from_uid, primary_key: :uid
  end
end
