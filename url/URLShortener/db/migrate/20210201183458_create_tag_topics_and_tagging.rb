class CreateTagTopicsAndTagging < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_topics do |t|
      t.string :topic, null: false
      t.integer :user_id, null: false
      t.integer :shortened_url_id, null: false

      t.timestamps
    end
  end
end
