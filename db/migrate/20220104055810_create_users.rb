class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.references :school, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.string :user_name
      t.string :user_password
      t.boolean :user_is_student

      t.timestamps
    end
  end
end
