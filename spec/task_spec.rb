require("spec_helper")

describe(Task) do

  describe(".all") do
    it('is empty at first') do
      expect(Task.all()).to(eq([]))
    end
  end

  describe("#description") do
    it("lets you read the description out") do
      test_task = Task.new({:description => "learn SQL", :list_id => 1, :due_date => Date.new(2017,1,1)})
      expect(test_task.description()).to(eq("learn SQL"))
    end
  end

  describe('#list_id') do
    it('lets you read the list ID out') do
      test_task = Task.new({:description => "learn SQL", :list_id => 1, :due_date => Date.new(2017,1,1)})
      expect(test_task.list_id()).to(eq(1))
    end
  end

  describe("#due_date") do
    it("lets you grab a due date from a new task") do
      test_task1 = Task.new({:description => 'play frisbee', :list_id => 1, :due_date => Date.new(2015,9,18)})
      expect(test_task1.due_date()).to(eq(Date.new(2015,9,18)))
    end
  end

  describe("#==") do
    it("is the same task if it has the same description") do
      task1 = Task.new({:description => "learn SQL", :list_id => 1, :due_date => Date.new(2017,1,1)})
      task2 = Task.new({:description => "learn SQL", :list_id => 2, :due_date => Date.new(2017,1,1)})
      expect(task1).to(eq(task2))
    end
  end

  describe("#save") do
    it("adds a task to the array of saved tasks") do
    test_track = Task.new({:description => "learn SQL", :list_id => 1, :due_date => Date.new(2017,1,1)})
    test_track.save()
    expect(Task.all()).to(eq([test_track]))
    end
  end

  describe("#sort") do
    it('sorts table by due date') do
      list_id = 1
      task1 = Task.new({:description => "COOL", :list_id => list_id, :due_date => Date.new(2017,1,1)})
      task1.save()
      task2 = Task.new({:description => "COOL2", :list_id => list_id, :due_date => Date.new(2016,1,1)})
      task2.save()
      expect(Task.sort(list_id)).to(eq([task2, task1]))
    end
  end
end