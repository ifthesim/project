class Transection < ActiveRecord::Base
  belongs_to :account

  def to_s
    return "Payee: #{payee} Category: #{category}"
  end
end
