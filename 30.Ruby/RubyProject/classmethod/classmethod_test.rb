# type1
class HelloWorld1
  class << HelloWorld1
    def hello(name)
      puts "#{name} said hello."
    end
  end
end

HelloWorld1.hello("John")
# type1_1 在类上下文之外定义类方法
class HelloWorld1_1

end
class << HelloWorld1_1
  def hello(name)
    puts "#{name} said hello."
  end
end

HelloWorld1_1.hello("John_1")

# type2
class HelloWorld2
  class << self
    def hello(name)
      puts "#{name} said hello."
    end
  end
end

HelloWorld2.hello("John1")

# type3
class HelloWorld3
  def HelloWorld3.hello(name)
    puts "#{name} said hello."
  end
end

HelloWorld3.hello("John2")

# type3_1 在类上下文之外定义类方法
class HelloWorld3_1
  
end
def HelloWorld3_1.hello(name)
    puts "#{name} said hello."
end

HelloWorld3_1.hello("John2_1")

# type4
class HelloWorld4
  def self.hello(name)
    puts "#{name} said hello."
  end
end

HelloWorld1.hello("John3")