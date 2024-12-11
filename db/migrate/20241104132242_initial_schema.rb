class InitialSchema < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      # Authentication
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :session_token, null: false
      t.boolean :is_admin, null: false, default: false

      # Profile
      t.string :name, null: false
      t.string :display_name, null: false
      t.string :language, null: false
      t.text :background, null: false
      t.text :bio, null: false
      t.string :url, null: false
      t.integer :followings_count, null: false, default: 0
      t.integer :bookmarks_count, null: false, default: 0

      t.timestamps

      # Soft delete
      t.datetime :deleted_at, null: true

      # Indexes
      t.index :email, unique: true
      t.index :session_token, unique: true
      t.index :deleted_at
    end

    create_table :categories do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :icon, null: false
      t.integer :sequence, null: false

      t.timestamps
    end

    create_table :pages do |t|
      t.references :category, null: false, foreign_key: true
      t.string :name, null: false
      t.boolean :is_verified, null: false, default: false
      t.text :bio, null: false
      t.integer :posts_count, null: false, default: 0
      t.integer :reviews_count, null: false, default: 0

      t.timestamps
      # Soft delete
      t.datetime :deleted_at, null: true

      t.index :deleted_at
    end

    create_table :page_managers do |t|
      t.references :page, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :role, null: false

      t.timestamps

      t.index [ :page_id, :user_id ], unique: true
    end

    create_table :page_followers do |t|
      t.references :page, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps

      t.index [ :page_id, :user_id ], unique: true
    end

    create_table :page_reviews do |t|
      t.references :page, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :content, null: false

      t.timestamps
    end

    create_table :page_posts do |t|
      t.references :page, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content, null: false

      t.timestamps
    end

    create_table :page_post_bookmarks do |t|
      t.references :page_post, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps

      t.index [ :page_post_id, :user_id ], unique: true
    end

    create_table :official_posts do |t|
      t.string :title, null: false
      t.text :content, null: false

      t.timestamps
    end

    create_table :official_post_bookmarks do |t|
      t.references :official_post, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps

      t.index [ :official_post_id, :user_id ], unique: true
    end
  end
end
