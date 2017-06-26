class AddCategoryIdToGroup < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :category_id, :integer
  end
end
