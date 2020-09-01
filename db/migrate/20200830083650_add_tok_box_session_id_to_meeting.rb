class AddTokBoxSessionIdToMeeting < ActiveRecord::Migration[5.2]
  def change
    add_column :meetings, :tokbox_session_id, :string
    add_column :meetings, :invitee_id, :integer
  end
end
