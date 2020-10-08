import java.util.*;
public class Kurs {
	String kursnamn;
	int kurskod;
	List<String> studenter = new ArrayList<String>();
	Larare larare;
	public Kurs(String a, int b){
		kursnamn=a;
		kurskod=b;
	}
	
	public String getNamn(){
		return kursnamn;
	}
	
	public void addStudent(Student a){
		studenter.add(a.getnamn());
		a.kurser.add(this.getNamn());
	}
	public void addLarare(Larare b){
		larare=b;
		b.kurser.add(this.getNamn());
	}
	public void getStudenter(){
		for (String f : studenter)
		System.out.println(f);
	}
	public void getLarare(){
		System.out.println(larare.getnamn());
	}
}
