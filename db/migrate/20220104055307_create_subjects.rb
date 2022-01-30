class CreateSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :subjects do |t|
      t.references :school, null: false, foreign_key: true
      t.string :subject_name
      t.boolean :subject_is_secret, null: false, default: false

      t.timestamps
    end
  end
end
