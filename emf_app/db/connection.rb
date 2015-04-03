require 'active_record'
ActiveRecord::Base.establish_connection(
  database: 'finance_db',
  adapter: 'postgresql'
)
