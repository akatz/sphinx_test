# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_sphinx_test_session',
  :secret      => '380d6e32c1ec36e6a04cceccf67ed197e1d2f0fb124758abe55592f16fed8a40ed9ddb3436a4a8556ada7589c63abfa421d6d523a0b0ece29578fc5511a7a874'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
