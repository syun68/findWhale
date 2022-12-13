class AddColumnsToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :title, :string
    add_column :posts, :place_prefecture, :string
    add_column :posts, :place_detail, :string
    add_column :posts, :description, :string
  end
end
