class HelloWorld
  def hi
    puts "first hi"
  end
  
  def hi
    puts "second hi"
  end
end

h = HelloWorld.new
h.hi