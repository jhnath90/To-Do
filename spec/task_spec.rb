require('rspec')
require('task')

describe(Task) do
  before() do
    Task.clear()
  end
    	
  describe("#decription") do  #describing the instance method description
    it("lets you give a description") do
      test_task	= Task.new("scrub the zebra")
      expect(test_task.description()).to(eq("scrub the zebra"))
    end
  end    

  describe(".all") do  # .all is a class method, not an instance method which is denoted with a #
  	it("is empty at first") do
  	  expect(Task.all()).to(eq([]))	
    end
  end	

  describe("#save") do
    it("adds a task to the array of saved tasks") do
    test_task = Task.new("wash the lion")
    test_task.save()
    expect(Task.all()).to(eq([test_task]))  
    end
  end

  describe(".clear") do
    it("empties out all of the saved tasks") do
      Task.new("wash the lion").save()
      Task.clear()
      expect(Task.all()).to(eq([]))
    end
  end      
end