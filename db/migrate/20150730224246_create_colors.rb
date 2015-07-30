class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.string :hex_code
      t.integer :vote_count, :default => 0
    end
    add_index(:colors, :hex_code, unique: true)
  end
end

