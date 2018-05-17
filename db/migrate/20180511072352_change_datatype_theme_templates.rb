class ChangeDataTypeThemeTemplates < ActiveRecord::Migration[4.2]
  def up
    change_column :spree_themes_templates, :body, :longtext
  end

  def down
    change_column :spree_themes_templates, :body, :text
  end
end
