class AddContextToReleaseDates < ActiveRecord::Migration[5.2]
  def change
    add_column :release_dates, :context, :string
  end
end
