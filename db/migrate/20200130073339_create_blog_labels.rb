class CreateBlogLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :blog_labels do |t|
      t.integer :blog_id
      t.integer :label_id

      t.timestamps
    end
  end
end
