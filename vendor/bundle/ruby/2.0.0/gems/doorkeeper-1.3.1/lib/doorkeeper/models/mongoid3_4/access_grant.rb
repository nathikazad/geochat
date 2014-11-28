require 'doorkeeper/models/mongoid/revocable'
require 'doorkeeper/models/mongoid/scopes'
require 'doorkeeper/models/mongoid/version'

module Doorkeeper
  class AccessGrant
    include Mongoid::Document
    include Mongoid::Timestamps
    include Doorkeeper::Models::Mongoid::Revocable
    include Doorkeeper::Models::Mongoid::Scopes
    extend Doorkeeper::Models::Mongoid::Version

    self.store_in collection: :oauth_access_grants

    if defined?(Moped::BSON)
      field :resource_owner_id, type: Moped::BSON::ObjectId
    else
      field :resource_owner_id, type: BSON::ObjectId
    end

    field :application_id, type: Hash
    field :token, type: String
    field :expires_in, type: Integer
    field :redirect_uri, type: String
    field :revoked_at, type: DateTime

    index({ token: 1 }, { unique: true })
  end
end
