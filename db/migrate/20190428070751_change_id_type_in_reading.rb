class ChangeIdTypeInReading < ActiveRecord::Migration[5.2]
  def up
    change_column :readings, :id, :string
  end

  def down
    change_column :readings, :id, :bigint
  end
end
