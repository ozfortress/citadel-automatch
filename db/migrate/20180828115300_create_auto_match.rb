class CreateAutoMatch < ActiveRecord::Migration[5.2]
  def change
    create_table :auto_match_registrations do |t|
      t.integer :match_id, null: false, index: { unique: true }
      t.integer :registered_by_id, null: false, index: true
      t.integer :home_team_confirmed_by_id
      t.integer :away_team_confirmed_by_id

      t.text :ip, null: false
      t.integer :port, null: false
      t.text :password, null: false

      t.string :token, null: false, unique: true
      t.string :user_token, null: false, unique: true

      t.timestamp :registered_at, null: false
    end

    add_foreign_key :auto_match_registrations, :league_matches, column: :match_id
    add_foreign_key :auto_match_registrations, :users, column: :registered_by_id
    add_foreign_key :auto_match_registrations, :users, column: :home_team_confirmed_by_id
    add_foreign_key :auto_match_registrations, :users, column: :away_team_confirmed_by_id

    create_table :auto_match_authorizations do |t|
      t.integer :match_id, null: false, index: { unique: true }
      t.integer :registered_by_id, null: false, index: true
      t.integer :home_team_confirmed_by_id, null: false
      t.integer :away_team_confirmed_by_id, null: false

      t.text :ip, null: false
      t.integer :port, null: false
      t.text :password, null: false

      t.string :token, null: true, index: true, unique: true

      t.string :match_logs, null: false, default: ''

      t.timestamp :registered_at, null: false
      t.timestamp :confirmed_at, null: false
      t.timestamp :completed_at
    end

    add_foreign_key :auto_match_authorizations, :league_matches, column: :match_id
    add_foreign_key :auto_match_authorizations, :users, column: :registered_by_id
    add_foreign_key :auto_match_authorizations, :users, column: :home_team_confirmed_by_id
    add_foreign_key :auto_match_authorizations, :users, column: :away_team_confirmed_by_id
  end
end
