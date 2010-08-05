# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_groupex_session',
  :secret      => '05846c8db0c1772c4debbda32a421b81fdb2008f6aa2e813495f8888d6c34007a4c3b38ff1b135a68c4bc7a31e7fe0da1ed6f9935594c308a7fc20c3b5556269'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
