require "employee"

class Startup
    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    attr_reader :name, :funding, :salaries, :employees

    def valid_title?(title)
        return @salaries.has_key?(title)
    end

    def >(other_startup)
        return self.funding > other_startup.funding
    end

    def hire(name, title)
        if self.valid_title?(title)
            @employees << Employee.new(name, title)
        else
            raise "invalid title"
        end
    end

    def size
        return @employees.length
    end

    def pay_employee(employee)
        if @funding < @salaries[employee.title]
            raise "not enough funding to pay employee"
        else
            employee.pay(@salaries[employee.title])
            @funding -= @salaries[employee.title]
        end
    end

    def payday
        @employees.each do |employee|
            self.pay_employee(employee)
        end
    end

    def average_salary
        sum = 0
        @employees.each do |employee|
            sum += @salaries[employee.title]
        end
        return sum.to_f / @employees.length
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(other_startup)
        @funding += other_startup.funding
        other_startup.salaries.each_pair do |title, amount|
            @salaries[title] = amount if !@salaries.has_key?(title)
        end
        @employees += other_startup.employees
        other_startup.close
    end
end
