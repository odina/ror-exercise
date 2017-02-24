class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.belongs_to :response
      t.string :answer

      t.timestamps null: false
    end
  end
end
