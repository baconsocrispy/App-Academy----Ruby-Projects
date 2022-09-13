class ChangeColumnNameReleaseDateModel < ActiveRecord::Migration[5.2]
  def change
    rename_column :release_dates, :release_type, :release_format
  end
end
