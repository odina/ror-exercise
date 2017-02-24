class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.belongs_to :web_survey
      t.string :name

      t.timestamps null: false
    end
  end
end
