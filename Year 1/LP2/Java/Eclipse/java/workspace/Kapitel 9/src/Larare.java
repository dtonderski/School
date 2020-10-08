import java.util.*;
public class Larare extends Person {
	List<String> kurser = new ArrayList<String>();
	public Larare(String a, String b, int c){
		super(a,b,c);
	}
	
	public void addKurs(Kurs a){
		a.addLarare(this);
	}
	
	public void getKurser(){
		for (String f : kurser)
		System.out.println(f);
	}
	
public static void main(String[] args){
	//Student David = new Student("David","Akvamaringatan 7C",18);
	//Student Adam = new Student("Adam","Baveringsgatan",24);
	//Kurs TekniskFysik = new Kurs("Teknisk fysik", 34);
	Larare Jana = new Larare("Jana","Vetej",100);
	//TekniskFysik.addLarare(Jana);
	//TekniskFysik.addStudent(Adam);
	//TekniskFysik.addStudent(David);
	Kurs Analys = new Kurs("Inledande matematisk analys",123);
	Analys.addLarare(Jana);
	Jana.getKurser();
	Analys.getLarare();
	Kurs TekniskFysik = new Kurs("Teknisk Fysik!", 1234);
	Student David = new Student("David","asd", 12);
	TekniskFysik.addStudent(David);
	TekniskFysik.addLarare(Jana);
	TekniskFysik.getStudenter();
	TekniskFysik.getLarare();
	//Adam.getKurser();
	//TekniskFysik.getStudenter();
}
}
