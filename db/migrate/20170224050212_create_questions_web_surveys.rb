class CreateQuestionsWebSurveys < ActiveRecord::Migration
  def change
    create_table :questions_web_surveys do |t|
      t.belongs_to :question, index: true
      t.belongs_to :web_surveys, index: true
    end
  end
end
