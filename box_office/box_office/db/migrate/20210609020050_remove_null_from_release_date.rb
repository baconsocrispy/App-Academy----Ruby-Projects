class RemoveNullFromReleaseDate < ActiveRecord::Migration[5.2]
  def up
    change_column_null :release_dates, :date, true
  end
  def down
    change_column_null :release_dates, :date, false
  end
end
