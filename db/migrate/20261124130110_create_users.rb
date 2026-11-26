class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :role
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
