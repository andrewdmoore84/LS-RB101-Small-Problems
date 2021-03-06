=begin
Problem

Stack Machine Interpretation

A stack is a list of values that grows and shrinks dynamically. In ruby, a stack is easily implemented as an Array that just uses the #push and #pop methods.

A stack-and-register programming language is a language that uses a stack of values. Each operation in the language operates on a register, which can be thought of as the current value. The register is not part of the stack. Operations that require two values pop the topmost item from the stack (that is, the operation removes the most recently pushed value from the stack), perform the operation using the popped value and the register value, and then store the result back in the register.

Consider a MULT operation in a stack-and-register language. It multiplies the stack value with the register value, removes the value from the stack, and then stores the result back in the register. Thus, if we start with a stack of 3 6 4 (where 4 is the topmost item in the stack), and a register value of 7, then the MULT operation will transform things to 3 6 on the stack (the 4 is removed), and the result of the multiplication, 28, is left in the register. If we do another MULT at this point, then the stack is transformed to 3, and the register is left with the value 168.

Write a method that implements a miniature stack-and-register-based programming language that has the following commands:

    n Place a value n in the "register". Do not modify the stack.
    PUSH Push the register value on to the stack. Leave the value in the register.
    ADD Pops a value from the stack and adds it to the register value, storing the result in the register.
    SUB Pops a value from the stack and subtracts it from the register value, storing the result in the register.
    MULT Pops a value from the stack and multiplies it by the register value, storing the result in the register.
    DIV Pops a value from the stack and divides it into the register value, storing the integer result in the register.
    MOD Pops a value from the stack and divides it into the register value, storing the integer remainder of the division in the register.
    POP Remove the topmost item from the stack and place in register
    PRINT Print the register value

All operations are integer operations (which is only important with DIV and MOD).

Programs will be supplied to your language method via a string passed in as an argument. Your program may assume that all programs are correct programs; that is, they won't do anything like try to pop a non-existent value from the stack, and they won't contain unknown tokens.

You should initialize the register to 0.

  Input(s): String (containing a list of commands forming a program)
  Output(s): Side-effect: Outputting varying amounts and values of integers depending upon string program 
  
  Explicit Rules:
    Input will be a valid program made up of integers and commands
    Commands and integers will be delimited by spaces
  Implicit Rules:
    Commands are typically operating on the register, although Push affects the stack. Some commands affect both the register and the stack, but the register is almost always involved
  
  Questions?

  Notes/Thoughts
  
  Use a case statement to return behavior per token?
  Split string into array of commands and iterate through it
  
Examples/Test Cases

minilang('PRINT')
# 0

minilang('5 PUSH 3 MULT PRINT')
# 15

minilang('5 PRINT PUSH 3 PRINT ADD PRINT')
# 5
# 3
# 8

minilang('5 PUSH POP PRINT')
# 5

minilang('3 PUSH 4 PUSH 5 PUSH PRINT ADD PRINT POP PRINT ADD PRINT')
# 5
# 10
# 4
# 7

minilang('3 PUSH PUSH 7 DIV MULT PRINT ')
# 6

minilang('4 PUSH PUSH 7 MOD MULT PRINT ')
# 12

minilang('-3 PUSH 5 SUB PRINT')
# 8

minilang('6 PUSH')
# (nothing printed; no PRINT commands)

Data Structures

String
Array (of tokens in program string)

Algorithms

Initialize register to 0 and stack to an empty array
Invoke #split to break program string into array of various tokens
Iterate through each token and perform operation specified
  n - Reassign register to n
  PUSH #push register value to stack
  POP #pop stack value and reassign register to that value
  ADD Pops a value from the stack and adds it to the register value, storing the result in the register.
  SUB Pops a value from the stack and subtracts it from the register value, storing the result in the register.
  MULT Pops a value from the stack and multiplies it by the register value, storing the result in the register.
  DIV Pops a value from the stack and divides it into the register value, storing the integer result in the register.
  MOD Pops a value from the stack and divides it into the register value, storing the integer remainder of the division in the register.
  PRINT Print the register value

Use 
=end

def minilang(program)
  tokens = program.split
  
  register = 0
  stack = []
  
  #binding.pry
  tokens.each do |token|
    
    case token
    when "PUSH" then stack.push(register)
    when "POP" then register = stack.pop
    when "ADD" then register += stack.pop
    when "SUB" then register -= stack.pop
    when "MULT" then register *= stack.pop
    when "DIV" then register /= stack.pop
    when "MOD" then register %= stack.pop
    when "PRINT" then puts register
    else register = token.to_i
    end
      
  end
  puts "~~~"
end
      
# minilang('PRINT')
# 0

# minilang('5 PUSH 3 MULT PRINT')
# # 15

# minilang('5 PRINT PUSH 3 PRINT ADD PRINT')
# # 5
# # 3
# # 8

# minilang('5 PUSH POP PRINT')
# # 5

# minilang('3 PUSH 4 PUSH 5 PUSH PRINT ADD PRINT POP PRINT ADD PRINT')
# # 5
# # 10
# # 4
# # 7

# minilang('3 PUSH PUSH 7 DIV MULT PRINT ')
# # 6

# minilang('4 PUSH PUSH 7 MOD MULT PRINT ')
# # 12

# minilang('-3 PUSH 5 SUB PRINT')
# # 8

# minilang('6 PUSH')
# # (nothing printed; no PRINT commands)

# FURTHER EXPLORATION: Figure out the string to pass to minilang to accomplish the below expression
#(3 + (4 * 5) - 7) / (5 % 3)

=begin
Have to store 7 first in the stack so that the subtraction can later be done in the proper order: 7 PUSH
Then 4 * 5 should be done: 4 PUSH 5 MULT
Subtract 7 and push value: SUB PUSH
Then add 3: 3 ADD
This should result in 16. Use PUSH to push to stack

Now push 3: 3 PUSH and then 5 MOD
Then DIV and see what happens...?
=end

minilang('3 PUSH 5 MOD PUSH 7 PUSH 4 PUSH 5 MULT SUB PUSH 3 ADD DIV PRINT')#PUSH 3 ADD 7 SUB')