class CreateGroupOwners < ActiveRecord::Migration[6.1]
  def change
    create_table :group_owners do |t|
      t.string     :uid, null: false
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end

    add_foreign_key :group_owners, :users, column: :uid, primary_key: :uid
  end
end
