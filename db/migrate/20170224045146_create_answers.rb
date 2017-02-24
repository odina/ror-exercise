class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.belongs_to :response
      t.belongs_to :question
      t.string :answer

      t.timestamps null: false
    end
  end
end
