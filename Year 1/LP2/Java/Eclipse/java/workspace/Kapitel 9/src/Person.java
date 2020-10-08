public class Person {
	String namn, adress;
	int alder;
	
	public Person(String a, String b, int c){
		namn=a;
		adress=b;
		alder=c;
	}
	
	public String getnamn(){
		return namn;
	}
	
	public String getadress(){
		return adress;
	}
	
	public int getalder(){
		return alder;
	}
	
	public void setAge(int b){
		alder=b;
	}
	
	public void setAdress(String x){
		adress=x;
	}
	
	public void setNamn(String x){
		namn=x;
	}
	
	public static void main(String[] args){
		Person a = new Person("David","Akvamaringatan", 18);
		System.out.println(a.getnamn());
		System.out.println(a.getadress());
		System.out.println(a.getalder());
		a.setAge(19);
		a.setNamn("David Tonderski");
		a.setAdress("Akvamaringatan 7C");
		System.out.println(a.getnamn());
		System.out.println(a.getadress());
		System.out.println(a.getalder());
	}

}
