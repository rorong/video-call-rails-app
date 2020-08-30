class AddTokBoxSessionIdToMeeting < ActiveRecord::Migration[5.2]
  def change
    add_column :meetings, :tokbox_session_id, :string
  end
end
