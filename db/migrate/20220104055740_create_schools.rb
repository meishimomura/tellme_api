class CreateSchools < ActiveRecord::Migration[6.1]
  def change
    create_table :schools do |t|
      t.string :school_name
      t.string :school_image_path

      t.timestamps
    end
  end
end
