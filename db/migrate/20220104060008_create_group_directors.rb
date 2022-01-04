class CreateGroupDirectors < ActiveRecord::Migration[6.1]
  def change
    create_table :group_directors do |t|
      t.references :subject, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
