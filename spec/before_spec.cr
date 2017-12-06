require "./spec_helper"

class Foo
  before def add(a : Int32, b : Int32)
    __before__
    a + b
  end
end

describe "before macro" do
  it "keeps original action" do
    foo = Foo.new
    foo.add(1,2).should eq(3)
  end

  it "provides before filter named 'before_xxx'" do
    log = nil

    foo = Foo.new
    foo.before_add {|a,b| log = "add(#{a},#{b})" }

    log.should eq(nil)

    foo.add(1,2).should eq(3)
    log.should eq("add(1,2)")
  end
end


