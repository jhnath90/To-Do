require('rspec')
require('pg')
require('list')

DB = PG.connect({:dbname => 'to_do_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM lists *;')
    config.include Capybara::DSL
  end
end

describe(List) do

  describe('.all') do
    it("starts off with no lists") do
      expect(List.all()).to(eq([]))
    end
  end


  describe("#name") do
    it("tell you its name") do
      list = List.new({:name => "Epicodus stuff",:id => nil})
      expect(list.name()).to(eq("Epicodus stuff"))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
        list = List.new({:name => "Epicodus stuff", :id => nil})
        list.save()
        expect(list.id()).to(be_an_instance_of(Fixnum))
      end
    end

  describe("#save") do
    it("lets you save lists to the database") do
      list = List.new({:name =>"Epicodus stuff",:id =>nil})
      list.save()
      expect(List.all()).to(eq([list]))
    end
  end

  describe(".find") do
    it("lets you find a list based on its id") do
      list = List.new({:name =>"Epicodus Work",:id => nil})
      list.save
      expect(List.find(list.id)).to(eq(list))
    end
  end

  describe("#tasks") do
    it("lets you find all tasks for a given list") do
      list = List.new({:name =>"Epicodus Work",:id => nil})
      list.save()
      task = Task.new({:description => 'Rock Out', :list_id => list.id(), :due_date => Date.new(2015,1,2)})
      task.save()
      expect(list.tasks()).to(eq([task]))
    end
  end

end









 