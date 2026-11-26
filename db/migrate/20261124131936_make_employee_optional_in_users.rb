class MakeEmployeeOptionalInUsers < ActiveRecord::Migration[8.1]
  def change
    change_column_null :users, :employee_id, true
  end
end
