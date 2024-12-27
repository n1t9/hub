class CreateCategoryOfficialPostJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_table :categories_official_posts do |t|
      t.references :category, null: false, foreign_key: true
      t.references :official_post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
