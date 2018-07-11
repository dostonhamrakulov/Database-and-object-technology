

public class Bookstore2 {
	
	public static final int ID[] = {1, 2, 3}; 
	public static final String book_name[] = {"PL/SQL", "JDBC", "JavaScript"};
	public static final int year[] = {2011, 2018, 2015};
	public static final String category[] = {"Science", "Science", "Science"};
	
	public static String Book(int id) {
		
		switch(id) {
		case 1:
			return book_name[1] + " is from "+ category[1] + ", published in " + year[1];
		case 2:
			return book_name[2] + " is from " + category[2] + ", published in " + year[2];
		case 3:
			return book_name[3] + " is from " + category[3] + ", published in " + year[3];
		default:
			return "Please, enter valid id";
		}
		 
	}
	public static void main(String[] args) {
		System.out.println(Book(1));
		
	}
	
}
