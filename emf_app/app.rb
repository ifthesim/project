require 'active_record'
require 'pg'
require 'pry'

require_relative 'db/connection'
require_relative 'lib/account'
require_relative 'lib/transection'


def get_account
  account_name = gets.chomp
  return Account.find_by(name:account_name)
end

def user_create_account
  user_account={}
  puts "Please enter the name of the new account?"
  user_account[:name]= gets.chomp
  puts "What is your initial deposit?"
  user_account[:balance]= gets.chomp.to_i
  return user_account
end

def user_add_transections
  tran_attr = {}
  puts "What is the name of the payee?"
  tran_attr[:payee] = gets.chomp
  puts "What is the amount?"
  tran_attr[:amount] = gets.chomp.to_i
  puts "What is the category please type 'debit' or 'credit'?"
  tran_attr[:category] = gets.chomp
  puts "Do you want to debit if 'yes' put the amount or else keep it blank and press enter?"
  tran_attr[:debit] = gets.chomp
  puts "Do you want to credit if 'yes' put the amount or else keep it blank and press enter?"
  tran_attr[:credit] = gets.chomp
  return tran_attr
end

def clear_screen
  system("clear")
end

def select_account
  puts Account.all
  puts "Select your account by its Account Id:"
  account_id = gets.chomp
  return Account.find_by(id: account_id)
end

def select_transaction(account)
  puts "Which Transaction?"
  puts account.transections
  puts "Select the Id of the Transection:"
  transection_id = gets.chomp
  return Account.Transection.find_by(id: transection_id)
end

def list_of_accounts
  puts"List of all accounts given below by name."
  empty_space
  Account.all.each do |account|
    puts account.to_s_i
  end
end

def main_menu
  empty_space
  empty_space
  puts "***Welcome to the main menu of Elon Musk Finance***"
  empty_space
  puts "Choose an option:
  1. List of all accounts.
  2. See initial account balance and account id by individual account.
  3. Open a new a accont.
  4. Close a account.
  5. Add a transection.
  6. See all transection.
  7. Show transection by catagory.
  8. Delete a transection.
  9. See total day ending balance at Elon Musk Finance.
  10. Quit."
  return gets.chomp
end

def design_star_line
  puts"**************************************************************************"
end

def empty_space
  puts" "
end

def withdraw_var
  Transection.sum(:credit)
end

def deposit_var
  Transection.sum(:debit)
end

def balance_var
  Transection.sum(:amount)
end

def all_transection
  all_tran= Transection.all
  puts all_tran
end



loop do

  choice = main_menu
  case choice

  when "1"
    clear_screen
    design_star_line
    puts"***All the accounts with Elon Musk Finance:***"
    design_star_line
    empty_space
    list_of_accounts
    empty_space
    design_star_line
    puts"************ Confidentail Information ************"
    design_star_line

  when "2"
    clear_screen
    design_star_line
    list_of_accounts
    design_star_line
    puts "Please type a name of account from the above to see the balance and id of the account:"
    puts get_account
    empty_space

  when "3"
    clear_screen
    new_account = Account.create(user_create_account)
    new_account.save
    puts new_account

  when "4"
    clear_screen
    list_of_accounts
    empty_space
    puts "Please type the name of the account you want to close:"
    delete_account= gets.chomp
    Account.find_by(name:delete_account).destroy

  when "5"
    account = select_account
    new_transections = Transection.create(user_add_transections)
    new_transections.account_id = account.id
    new_transections.save

  when "6"
    all_transection

  when "7"
    puts "Type your category debit or credit?"
    category_var = gets.chomp
    category_transections = Transection.where(category: category_var)
    total = 0
    category_transections.each do |transection|
      puts "Transections details:"
      puts "Payee:#{transection.payee} Amount:#{transection.amount} Credit:#{transection.credit} Debit:#{transection.debit}"
    end

  when "8"
    puts "Below is the list of all Transections:"
    empty_space
    all_transection
    empty_space
    puts "Please type the name of the payee which you want to delete:"
    payee_name = gets.chomp
    Transection.find_by(payee:payee_name).destroy

  when "9"
    current_balance = Account.sum(:balance)
    total_balance = current_balance + (deposit_var - withdraw_var)
    puts total_balance
  when "10"
    break
  end
end
