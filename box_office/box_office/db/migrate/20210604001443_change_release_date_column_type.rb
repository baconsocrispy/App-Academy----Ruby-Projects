class ChangeReleaseDateColumnType < ActiveRecord::Migration[5.2]
  def change
    rename_column :release_dates, :type, :release_type
  end
end
