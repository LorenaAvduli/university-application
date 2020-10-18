class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :code
      t.string :name
      t.string :semester
      t.text :catalog_data

      t.timestamps
    end
  end
end
