class ConnectorNotConnection < ActiveRecord::Migration
  def change
    rename_column :theorems, :connection, :connector
  end
end
