class CreateMeetings < ActiveRecord::Migration[5.2]
  def change
    create_table :meetings do |t|
      t.string :title
      t.string :description
      t.string :tokbox_token
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
