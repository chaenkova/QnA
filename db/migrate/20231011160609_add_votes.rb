class AddVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.integer :value, default: 0
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :votable, polymorphic: true, null: false

      t.timestamps
    end
  end

end
