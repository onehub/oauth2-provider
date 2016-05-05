class SongkickOauth2SchemaAddUniqueIndexes < ActiveRecord::Migration
  FIELDS = [:code, :refresh_token_hash]

  def self.up
    FIELDS.each do |field|
      remove_index :oauth2_authorizations,  :name => "oa2_client_id_#{field.to_s}"
      add_index :oauth2_authorizations, [:client_id, field], { :name => "oa2_client_id_#{field.to_s}", :unique => true }
    end
    remove_index :oauth2_authorizations, :name =>  "oa2_access_token_hash"
    add_index :oauth2_authorizations, [:access_token_hash], {:name => "oa2_access_token_hash", :unique => true}

    remove_index :oauth2_clients, [:client_id]
    add_index :oauth2_clients, [:client_id], :unique => true

    add_index :oauth2_clients, [:name], :unique => true
  end

  def self.down
    FIELDS.each do |field|
      remove_index :oauth2_authorizations,  :name => "oa2_client_id_#{field.to_s}"
      add_index :oauth2_authorizations, [:client_id, field], :name => "oa2_client_id_#{field.to_s}"
    end
    remove_index :oauth2_authorizations,  :name => "oa2_access_token_hash"
    add_index :oauth2_authorizations, [:access_token_hash], :name => "oa2_access_token_hash"

    remove_index :oauth2_clients, [:client_id]
    add_index :oauth2_clients, [:client_id]

    remove_index :oauth2_clients, [:name]
  end
end

