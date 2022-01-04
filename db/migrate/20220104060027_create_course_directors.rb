class CreateCourseDirectors < ActiveRecord::Migration[6.1]
  def change
    create_table :course_directors do |t|
      t.string     :uid, null: false

      t.timestamps
    end

    add_foreign_key :course_directors, :users, column: :uid, primary_key: :uid
  end
end
