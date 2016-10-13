module M
  def meth
    "meth"
  end
end

class C
  include M
end

c1 = C.new
p c1.meth
p C.ancestors
p C.superclass