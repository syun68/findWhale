class RemovePlacePrefectureFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :place_prefecture, :string
  end
end
