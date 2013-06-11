## Animal is-a object look at the extra credit
class Animal
end

## Dog is-a Animal, has-a name
class Dog < Animal

	def initialize(name)
		## ??
		@name = name
	end
end

## Cat is-a Animal, has-a name
class Cat < Animal

	def initialize(name)
		## ??
		@name = name
	end
end

## Person is-a object, has-a name, pet
class Person

	def initialize(name)
		## ?
		@name = name

		## Person has-a pet of some kind
		@pet = nil
	end

	attr_accessor :pet
end

## Employee is-a Person, has-a name, salary
class Employee < Person

	def initialize(name, salary)
		## ?? hm what is this strange magic?
		super(name)
		## ??
		@salary = salary
	end

end

## Fish is-a Object
class Fish
end

## Salmon is-a Fish
class Salmon < Fish
end

## Halibut is-a Fish
class Halibut < Fish
end

## rover is-a Dog
rover = Dog.new("Rover")

## satan is-a Cat
satan = Cat.new("Satan")

## mary is-a Person
mary = Person.new("Mary")

## mary has-a pet satan
mary.pet = satan

## frank is-a employee, has-a name Frank, has-a salary 120000
frank = Employee.new("Frank", 120000)

## frank has-a pet rover
frank.pet = rover

# flipper is-a Fish
flipper = Fish.new()

## crouse is-a Salmon
crouse = Salmon.new()

## harry is-a Halibut
harry = Halibut.new()


