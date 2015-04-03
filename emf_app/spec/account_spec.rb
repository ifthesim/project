require 'spec_helper'

require 'active_record'
require_relative '../lib/account'

ActiveRecord::Base.establish_connection(
  database: 'finance_db',
  adapter: 'postgresql'
)

describe Account do
  it "sample spec" do
    expect(2+2).to eq(4)
  end

  subject(:account) { Account.new(name: 'bob') }
  describe '.name' do
    it "is assignable via constructor" do
      expect(account.name).to eq('bob')
    end
  end

  describe '.balance' do
    it "should add up, when only Credit transactions" do
      # create a new transaction
      bob = Account.find_by(name: "Bob")
      bob.balance
      # account.transections.build(credit: 10)
      # account.transections.build(credit: 30)
      # expect(account.balance).to eq(40)
      expect(bob.balance).to eq(balance:500)
    end

    it "should add up, when only Debit transactions"
    it "should add up, when both Credit & Debit transactions"
  end
end
