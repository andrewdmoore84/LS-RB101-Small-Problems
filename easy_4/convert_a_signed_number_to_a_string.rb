def get_digit_array(num)
  return [0] if num == 0
  
  digits = []

  while num > 0
    digits << (num % 10)
    num /= 10
  end

  digits
end

def convert_to_string(digits)
  str_digits = { 1 => "1", 2 => "2", 3 => "3", 4 => "4", 5 => "5",
                 6 => "6", 7 => "7", 8 => "8", 9 => "9", 0 => "0" }
  
  str_array = []
  
  digits.each { |num| str_array << str_digits[num] }
  
  str = str_array.reverse.join
  
  str
end

def integer_to_string(num)
  digits = get_digit_array(num)
  str_nums = convert_to_string(digits)
end

def signed_integer_to_string(num)
  sign = ""
  
  if num < 0
    sign = "-"
  elsif num > 0
    sign = "+"
  end
   
  str = integer_to_string(num.abs)
  
  str = str.prepend(sign)
  
  str
end

p signed_integer_to_string(4321) == '+4321'
p signed_integer_to_string(-123) == '-123'
p signed_integer_to_string(0) == '0'