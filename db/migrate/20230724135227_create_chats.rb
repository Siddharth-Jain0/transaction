class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.references :sender
      t.references :reciever
      t.string :message
      t.timestamps
    end
  end
end
