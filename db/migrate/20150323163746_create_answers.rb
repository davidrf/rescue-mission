class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :description, null: false
      t.string :question_id, null: false
      t.index :question_id

      t.timestamps
    end
  end
end
