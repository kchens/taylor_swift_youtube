class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.belongs_to :user
      t.belongs_to :video
      t.boolean :like, default: false
      t.boolean :love, default: false

      t.timestamps
    end
  end
end


