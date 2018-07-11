//package practical_work;

//Class declaration
public class Employee {
	
	//This Employee class defines objects like database
	private int employee_id;
	private String first_name;
	private String last_name;
	private int salary;
	
	//Defining constructors similar as defining the type of database objects (Employee object)
	public Employee(int employee_id, String first_name, String last_name, int salary) {
		super();
		this.employee_id = employee_id;
		this.first_name = first_name;
		this.last_name = last_name;
		this.salary = salary;
	}
	
	//Each of these Getter methods needs to be created to return objects
	public int getEmployee_id() {
		return employee_id;
	}
	public String getFirst_name() {
		return first_name;
	}
	public String getLast_name() {
		return last_name;
	}
	public int getSalary() {
		return salary;
	}
	
}
