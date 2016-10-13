#!/usr/bin/ruby

# 定义在 trig.rb 文件中的模块

module Trig
   PI = 3.141592654
   def Trig.sin(x)
       puts "Trig.sin"
   end
   def Trig.cos(x)
       puts "Trig.cos"
   end
end

module Kernel
  def tan(x)
     puts "Trig.tan"
   end
   
   module_function :tan
end