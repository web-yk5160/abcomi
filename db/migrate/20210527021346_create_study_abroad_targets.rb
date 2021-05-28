class CreateStudyAbroadTargets < ActiveRecord::Migration[6.1]
  def change
    create_table :study_abroad_targets do |t|
      t.string :target_country
      t.string :target_state
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
