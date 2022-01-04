class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.references :comment, null: false, foreign_key: true
      t.string     :uid, null: false

      t.timestamps
    end

    add_foreign_key :votes, :users, column: :uid, primary_key: :uid
  end
end
