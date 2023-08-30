class AddNutritionalInformationToArticleNames < ActiveRecord::Migration[7.0]
  def change
    add_column :article_names, :ingredients, :text
    add_column :article_names, :energy_value, :decimal
    add_column :article_names, :fats, :string
    add_column :article_names, :saturated_fats, :string
    add_column :article_names, :carbohydrates, :string
    add_column :article_names, :sugars, :string
    add_column :article_names, :proteins, :string
    add_column :article_names, :salt, :string
  end
end
