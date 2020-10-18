class CreateAssessmentItems < ActiveRecord::Migration[6.0]
  def change
    create_table :assessment_items do |t|
      t.string :name
      t.decimal :weight, :precision => 1, scale: 1
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
