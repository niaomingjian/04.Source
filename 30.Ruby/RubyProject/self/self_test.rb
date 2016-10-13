class HelloWorld
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
  
  def test_name
    name = "Ruby"
    #self.name = "Ruby"
  end
end

h = HelloWorld.new("program")
h.test_name

puts h.name