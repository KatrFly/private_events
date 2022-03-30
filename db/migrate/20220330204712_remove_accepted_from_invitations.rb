class RemoveAcceptedFromInvitations < ActiveRecord::Migration[6.1]
  def change
    remove_column :invitations, :accepted, :boolean
  end
end
