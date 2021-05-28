class CreateStudyAbroadExpectations < ActiveRecord::Migration[6.1]
  def change
    create_table :study_abroad_expectations do |t|
      t.string :expected_country
      t.string :expected_state
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
