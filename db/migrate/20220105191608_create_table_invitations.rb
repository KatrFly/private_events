class CreateTableInvitations < ActiveRecord::Migration[6.1]
  def change
    create_table :invitations do |t|

      t.belongs_to :event
      t.belongs_to :user
      t.timestamps
    end
  end
end
