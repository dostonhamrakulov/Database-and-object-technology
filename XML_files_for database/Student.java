public class Student {
	

	public static String myStr() {

		//Creating array from objects
		String student[] = new String[5];
		
		
		String myString = "";

		//Filling array based on Object Construction
		student[0] = "Doston";
		student[1] = "Hamrakulov";
		student[2] = "$1000000";
		student[3] = "Samarkand";
		student[4] = "Uzbekistan";

		for (int i = 0; i < student.length; i++) {
			myString = myString + student[i] + "  ";
		}
		return myString;
	}
	
	public static void main(String[] args) {
		Student st = new Student();
		System.out.println(st.myStr());
	}
}