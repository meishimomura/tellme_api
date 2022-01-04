class CreateCommentImages < ActiveRecord::Migration[6.1]
  def change
    create_table :comment_images do |t|
      t.references :comment, null: false, foreign_key: true
      t.string :comment_image_path

      t.timestamps
    end
  end
end
