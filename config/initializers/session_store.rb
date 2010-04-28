# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_spamservice_session',
  :secret      => '7b1782a3c18b9d1ce87a95b26dc281e0811aa5a55c19a5d382058805d73dd49bd1e83974a172da5ec6d48449791bb4b317e2c22d95f10927a038be91caed82b9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
