class AddStatusToInvitations < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      CREATE TYPE invitation_status AS ENUM ('open', 'accepted', 'declined');
    SQL
    add_column :invitations, :invitation_status, :invitation_status
  end

  def down
    remove_column :invitations, :invitation_status
    execute <<-SQL
      DROP TYPE invitation_status;
    SQL
  end
end
