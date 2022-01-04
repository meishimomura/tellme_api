class CreateMasterUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :master_users do |t|
      t.references :school, null: false, foreign_key: true
      t.string :master_user_name
      t.string :master_user_password

      t.timestamps
    end
  end
end
