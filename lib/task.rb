class Task

  attr_reader(:description, :list_id, :due_date)
  tasks = []

  def initialize(attributes)
    @description = attributes.fetch(:description)
    @list_id = attributes.fetch(:list_id)
    @due_date = attributes.fetch(:due_date)
  end

  define_singleton_method(:all) do
    returned_tasks = DB.exec("SELECT * FROM tasks;")
    tasks = []
    returned_tasks.each() do |task|
      description = task.fetch("description")
      list_id = task.fetch("list_id").to_i()
      due_date = Date.parse(task.fetch("due_date"))
      tasks.push(Task.new({:description => description,:list_id => list_id, :due_date => due_date}))
    end
    tasks
  end

  define_method(:==) do |another_task|
    self.description().==(another_task.description())
  end

  define_method(:save) do
    DB.exec("INSERT INTO tasks (description, list_id, due_date) VALUES ('#{@description}', #{@list_id}, '#{@due_date}');")
  end

  define_singleton_method(:sort) do |id|
    returned_tasks = DB.exec("SELECT * FROM tasks WHERE list_id = #{id} ORDER BY due_date;")
    tasks = []
    returned_tasks.each() do |task|
      description = task.fetch("description")
      list_id = task.fetch("list_id").to_i()
      due_date = Date.parse(task.fetch("due_date"))
      tasks.push(Task.new({:description => description, :list_id => list_id, :due_date => due_date}))
    end
    tasks
  end


end #end of class