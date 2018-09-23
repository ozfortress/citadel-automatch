class CreateAutoMatch < ActiveRecord::Migration[5.2]
  def change
    create_table :auto_match_registrations do |t|
      t.integer :match_id, null: false, index: { unique: true }
      t.integer :registered_by_id, null: false, index: true
      t.boolean :confirmed_by_registered_by, null: false, default: false

      t.string :token, null: false, index: true, unique: true

      t.timestamp :registered_at, null: false
    end

    add_foreign_key :auto_match_registrations, :league_matches, column: :match_id
    add_foreign_key :auto_match_registrations, :users, column: :registered_by_id

    create_table :auto_match_authorizations do |t|
      t.integer :match_id, null: false, index: { unique: true }
      t.integer :registered_by_id, null: false, index: true
      t.integer :confirmed_by_id, null: false, index: true

      t.string :token, null: false, index: true, unique: true

      t.string :match_logs, null: false, default: ''

      t.timestamp :registered_at, null: false
      t.timestamp :confirmed_at, null: false
      t.timestamp :completed_at
    end

    add_foreign_key :auto_match_authorizations, :league_matches, column: :match_id
    add_foreign_key :auto_match_authorizations, :users, column: :registered_by_id
    add_foreign_key :auto_match_authorizations, :users, column: :confirmed_by_id
  end
end
