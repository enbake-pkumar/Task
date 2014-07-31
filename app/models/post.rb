class Post < ActiveRecord::Base
  
  def self.luhnother(ccNumber)
	  ccNumber = ccNumber.gsub(/D/,'').split(//).collect { |digit| digit.to_i }
	  parity = ccNumber.length % 2

	  sum = 0
	  ccNumber.each_with_index do |digit,index|
	    digit = digit * 2 if index%2==parity
	    digit = digit - 9 if digit > 9
	    sum = sum + digit
	  end

	  return (sum%10)==0
   end
   def self.add_checksum(number)
    values = number.to_s.reverse.scan(/\d/).map { |x| x.to_i }
    values = values.each_with_index.map { |d, i|
      d *= 2 if i.even?
      d > 9 ? d - 9 : d
    }
    sum = values.inject(0) { |m, x| m + x }
    mod = 10 - sum % 10
    mod==10 ? 0 : mod
    return (number + "#{mod}")
  end

end
