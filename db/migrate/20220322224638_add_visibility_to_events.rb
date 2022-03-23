class AddVisibilityToEvents < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      CREATE TYPE visibility_status AS ENUM ('private', 'only_friends', 'public');
    SQL
    add_column :events, :visibility, :visibility_status
  end

  def down
    remove_column :events, :visibility
    execute <<-SQL
      DROP TYPE visibility_status;
    SQL
  end
end
