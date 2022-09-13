class Employee
    attr_reader :salary
    def initialize(name, title, salary, boss)
        @name = name
        @title = title
        @salary = salary
        @boss = boss
    end
    def bonus(multiplier)
        bonus = @salary * multiplier
        bonus
    end
end

class Manager < Employee
    def initialize(reports)
        super
        @reports = reports
    end
    def bonus(multiplier)
        total_salary_of_reports = @reports.inject(0) { |sum, emp| sum + emp.salary }
        bonus = total_salary_of_reports * multiplier
        bonus
    end
end

ned = Manager.new("Ned", "Founder", 1000000,nil,[darren])
darren = Manager.new("Darren","TA Manager", 78000,ned, [shawna, david])
shawna = Employee.new("Shawna", "TA", 12000, darren)
david = Employee.new("David", "TA", 10000, darren)

p ned.bonus(5)