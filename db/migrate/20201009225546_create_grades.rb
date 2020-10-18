class CreateGrades < ActiveRecord::Migration[6.0]
  def change
    create_table :grades do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.references :assessment_item, null: false, foreign_key: true
      t.string :exam
      t.integer :score

      t.timestamps
    end
  end
end
