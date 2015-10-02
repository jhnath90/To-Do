class Task
	@@all_tasks = [] #this is a class variable, hence the @@

  define_method(:initialize) do |description|
  	@description = description #instance variable description set equal to the parameter description
  end

  define_method(:description) do #this is an instance method
    @description
  end

  define_singleton_method(:all) do  #this is a class method, hence the define singleton method 
  	@@all_tasks
  end	

  define_method(:save) do
  	@@all_tasks.push(self)
  end
  
  define_singleton_method(:clear) do
    @@all_tasks = []
  end  	
end    	