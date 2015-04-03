class Account < ActiveRecord::Base
  has_many :transections, dependent: :destroy

    def to_s
      return "Name: #{name} Balance: #{balance} Account id: #{id}"
    end

    def to_s_i
      return "Name: #{name}"
    end
 end
