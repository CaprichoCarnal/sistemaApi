class CreateArticleNames < ActiveRecord::Migration[7.0]
  def change
    create_table :article_names do |t|
      t.references :family, null: false, foreign_key: true
      t.string :code
      t.string :name

      t.timestamps
    end
  end
end
