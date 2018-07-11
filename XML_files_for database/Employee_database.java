public class Employee_database {
	
	public static void main(String args[]) {
		
		//Creating array from objects
		Employee employee[] = new Employee[4];
		
		//Filling array based on Object Construction
		employee[0] = new Employee(1, "Doston", "Hamrakulov", 10000);
		employee[1] = new Employee(2, "Orifjon", "Doniyarov", 9000);
		employee[2] = new Employee(3, "Bekjon", "Egamov", 12000);
		employee[3] = new Employee(4, "Xusan", "Nasimov", 5000);
		
		//Here, displaying the output
		for( Employee em : employee) {
			System.out.println("Employee, Number: " + em.getEmployee_id() + ", " 
						+ em.getFirst_name() + " " + em.getLast_name() 
						+ " get $" + em.getSalary() + " salary");
		}
	}
}

