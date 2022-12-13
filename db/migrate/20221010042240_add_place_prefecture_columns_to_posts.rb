class AddPlacePrefectureColumnsToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :place_prefecture, :integer, null: false, default: 0
  end
end
