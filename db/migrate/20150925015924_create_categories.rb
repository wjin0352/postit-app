class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.datetime :updated_at
      t.datetime :created_at
    end
  end
end
