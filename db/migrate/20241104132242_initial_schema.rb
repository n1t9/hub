class InitialSchema < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.text :bio, null: false
      t.text :background, null: false
      t.string :language, null: false
      t.boolean :email_verified, null: false, default: false
      t.string :session_token, null: false
      t.integer :followings_count, null: false, default: 0
      t.integer :bookmarks_count, null: false, default: 0
      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :session_token, unique: true

    create_table :categories do |t|
      t.string :name, null: false
      t.string :icon, null: false
      t.timestamps
    end

    create_table :keywords do |t|
      t.references :category, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :sequence, null: false
      t.timestamps
    end

    create_table :pages do |t|
      t.integer :genre, null: false
      t.string :name, null: false
      t.integer :status, null: false
      t.boolean :is_verified, null: false, default: false
      t.text :bio, null: false
      t.integer :posts_count, null: false, default: 0
      t.integer :reviews_count, null: false, default: 0
      t.timestamps
    end
    add_index :pages, :genre

    create_table :page_keywords do |t|
      t.references :page, null: false, foreign_key: true
      t.references :keyword, null: false, foreign_key: true
      t.integer :sequence, null: false
      t.timestamps
    end
    add_index :page_keywords, [ :page_id, :keyword_id ], unique: true

    create_table :page_users do |t|
      t.references :page, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :role, null: false
      t.timestamps
    end
    add_index :page_users, [ :page_id, :user_id ], unique: true

    create_table :page_followers do |t|
      t.references :page, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
    add_index :page_followers, [ :page_id, :user_id ], unique: true

    create_table :page_reviews do |t|
      t.references :page, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :content, null: false
      t.timestamps
    end

    create_table :page_posts do |t|
      t.references :page, null: false, foreign_key: true
      t.integer :status, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.timestamps
    end

    create_table :page_post_bookmarks do |t|
      t.references :page_post, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
    add_index :page_post_bookmarks, [ :page_post_id, :user_id ], unique: true

    create_table :official_posts do |t|
      t.integer :status, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.timestamps
    end

    create_table :official_post_bookmarks do |t|
      t.references :official_post, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
    add_index :official_post_bookmarks, [ :official_post_id, :user_id ], unique: true
  end
end
