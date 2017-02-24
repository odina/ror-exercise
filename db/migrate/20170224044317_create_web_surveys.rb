class CreateWebSurveys < ActiveRecord::Migration
  def change
    create_table :web_surveys do |t|
      t.belongs_to :user
      t.string :title
      t.string :shortlink_slug

      t.timestamps null: false
    end
  end
end
