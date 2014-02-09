class CreateUserSettings < ActiveRecord::Migration
  def change
    create_table :user_settings do |t|
      t.boolean :receive_broadcast
      t.boolean :receive_email
      t.boolean :receive_user_messages
      t.boolean :visible

      t.timestamps
    end
  end
end
