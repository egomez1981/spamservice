class CreateUserprefs < ActiveRecord::Migration
  def self.up
    create_table :userprefs, {:primary_key => :prefid} do |t|
      t.string :username, :limit => 100, :null => false
      t.string :preference, :limit => 50, :null => false
      t.string :value, :limit => 100, :null => false
      t.integer :prefid, :null => false
    end

    add_index :userprefs, :username
  end

  def self.down
    drop_table :userprefs
  end
end
