require_relative 'connection'
require_relative '../lib/account'
require_relative '../lib/transection'

Account.destroy_all
Transection.destroy_all

accounts = Account.create([
  {name: "bob", balance: 500}
])

bob = Account.find_by(name:"bob")
bobs_transections = bob.transections.create([{payee: "Ann", amount: 100, category: "debit", credit: 100}])
