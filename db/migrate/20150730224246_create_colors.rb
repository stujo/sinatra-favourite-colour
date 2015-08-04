class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.string :name
      t.string :hex_code
      t.integer :vote_count, :default => 0
    end
  end
end

