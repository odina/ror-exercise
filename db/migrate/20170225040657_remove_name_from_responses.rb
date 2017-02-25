class RemoveNameFromResponses < ActiveRecord::Migration
  def change
    remove_column :responses, :name, :string
  end
end
