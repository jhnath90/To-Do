class List
  attr_reader(:name, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_lists = DB.exec("SELECT * FROM lists;")
    lists = []
    returned_lists.each() do |list|
      name = list.fetch('name')
      id = list.fetch('id').to_i()
      lists.push(List.new({:name => name, :id => id}))
    end
    lists
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    # sort = DB.exec("SELECT description, due_date FROM tasks ORDER BY due_date;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:==) do |another_list|
    self.name().==(another_list.name()).&(self.id().==(another_list.id()))
  end

  define_singleton_method(:find) do |id|
    all_lists = List.all()
    found_list = nil
    all_lists.each() do |list|
      if list.id().==(id)
        found_list = list
      end
    end
    found_list
  end

  define_method(:tasks) do
    returned_tasks = DB.exec("SELECT * FROM tasks WHERE list_id = #{@id};")
    tasks = []
    returned_tasks.each() do |task|
      description = task.fetch('description')
      list_id = task.fetch('list_id').to_i()
      due_date = Date.parse(task.fetch('due_date'))
      tasks.push(Task.new({:description => description, :list_id => list_id, :due_date => due_date}))
    end
    tasks
  end

end #end of class