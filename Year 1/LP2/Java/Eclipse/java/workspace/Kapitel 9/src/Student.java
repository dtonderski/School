import java.util.ArrayList;
import java.util.List;

public class Student extends Person {
	List<String> kurser = new ArrayList<String>();

	public Student(String a, String b, int c) {
		super(a, b, c);
		// TODO Auto-generated constructor stub
	}
	
	public void addKurs(Kurs a){
		a.addStudent(this);
	}
	public void getKurser(){
		for (String f : kurser)
		System.out.println(f);
	}
}
