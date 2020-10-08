import java.lang.Math;


public class RatNum implements Cloneable{
	//STEG 1
	public static int sgd(int m, int n){
		//ger felmeddelande om m eller n = 0
		if(m==0||n==0){
			throw new IllegalArgumentException();
		}
		//Euklides algoritm
		while(true){
			int r=m%n;
			if(r==0){
				return Math.abs(n);
			}
			else{
				m=n;
				n=r;
			}
		}
	}
	
	
	
	
	//STEG 2
	int taljare;
	int namnare;
	public RatNum(){
		taljare = 0;
		namnare = 1;
	}
	
	public RatNum(int a){
		taljare = a;
		namnare = 1;
	}
	
	public RatNum(int a, int b){
		if(b==0){
			throw new NumberFormatException("Denominator=0");
		}
		//ser till att nämnaren är positiv och byter tecken på a om tecken på b byts
		if(b<0){
			a=-a;
			b=-b;
		}
		//initierar täljaren till 0 och nämnaren till b om a=0 och b!=0
		if(a==0){
			taljare=a;
			namnare=b;
		}
		//initierar täljaren till a och nämnaren till b om sgd(a,b) == 0
		else if(sgd(a,b)==0){
			taljare=a;
			namnare=b;
		}
		//initierar täljaren till a delat med den största gemensamma faktorn och nämnaren till b delat med den största gemensamma faktorn
		else{
			taljare = a/sgd(a,b);
			namnare = b/sgd(a,b);
		}
	}
	//returnar täljaren
	public int getNumerator(){
		return taljare;
	}
	
	//returnar nämnaren
	public int getDenominator(){
		return namnare;
	}
	
	//En metod som skriver ut täljaren och nämnaren för tester
	public void printit(){
		System.out.println(taljare + ", " + namnare);
	}
	//"Kopieringskonstruktor"
	public RatNum(RatNum r){
		taljare=r.getNumerator();
		namnare=r.getDenominator();
	}
	
	
	
	//STEG 3
	//Returnerar det aktuella talet som en text med formen "a/b".
	public String toString(){
		if(taljare==0){
			return "0";
		}
		if(Math.abs(taljare)>=namnare){
			if(namnare==1){
				return Integer.toString(taljare);
			}
			if(taljare<0){
				int m=-taljare;
				int f=m%namnare;
				int h=(m-f)/namnare;
				int k=m-namnare*h;
				return "-" + h + " " + k + "/" + namnare;
			}
			else{
				int f = taljare%namnare;
				int h=(taljare-f)/namnare;
				int k=taljare-namnare*h;
				return h + " " + k + "/" + namnare;
			}
		}
		else{
			return taljare+"/" + namnare;
		}
	}
	//Returnerar ett närmevärde för det aktuella talet
	public double toDouble(){
		return (double)taljare/namnare;
	}
	//Kontrollerar om det är skrivet på korrekt sätt och i så fall skapar ett rationellt tal
	public static RatNum parse(String s){
		//Kontrollerar om parametern är på formen "a"
		if(s.matches("[0-9]+")){
			int	d = Integer.parseInt(s);
			return new RatNum(d);
		}
		//Kontrollerar om parametern är på formen "-a"
		else if(s.substring(0,1).equals("-") && s.substring(1,s.length()).matches("[0-9]+")){
			int d = Integer.parseInt(s);
			return new RatNum(d);
		}
		//Kontrollerar om / existerar, delar i så fall upp parametern i två delar: det som kommer före / och det som kommer efter. Om parametern är på formen "-a/-b" ges en NumberFormatException, annars görs det som kommer före / och det som kommer efter / om till två integers. Om det inte är rätt form så kommer en NumberFormatException ges.
		else if (s.indexOf('/')!=-1){
			int m=s.indexOf('/');
			if(s.substring(0,1).equals("-") && s.substring(m+1,m+2).equals("-")){
				throw new NumberFormatException();
			}
			String x = s.substring(0,m);
			String y = s.substring(m+1,s.length());
			int x1=Integer.parseInt(x);
			int y1=Integer.parseInt(y);
			return new RatNum(x1,y1);
			}
		else{
			throw new NumberFormatException();
		}
			
		}
	//Initierar det nya talet om det är skrivet på korrekt sätt, annars skickar felmeddelande
	public RatNum(String s){
		taljare=parse(s).getNumerator();
		namnare=parse(s).getDenominator();
	}
	//Försöker använda metoden clone, annars visar ett felmeddelande
	public Object clone(){
		try {
		return super.clone();
		} 
		catch (CloneNotSupportedException e) {
		throw new InternalError();
		}
	}
	
	//Jämför det aktuella talet med ett annat rationellt tal
	public boolean equals(RatNum r){
		return(taljare==r.getNumerator() && namnare==r.getDenominator());
		
	}
	//Jämför det aktuella talet med ett annat tal. Om det aktuella talet är mindre än r returneras true annars false
	public boolean lessThan(RatNum r){
		return(taljare*r.getDenominator()<r.getNumerator()*namnare);
	}
	//returnerar ett nytt rationellt tal som är summan av det aktuella talet och ett annat tal
	public RatNum add(RatNum r){
		int	m=r.getNumerator();
		int k=r.getDenominator();
		return new RatNum((taljare*k + m*namnare),(namnare*k));
	}
	//returnerar ett nytt rationellt tal som är differensen av det aktuella talet och ett annat tal
	public RatNum sub(RatNum r){
		int	m=r.getNumerator();
		int k=r.getDenominator();
		return new RatNum((taljare*k - m*namnare),(namnare*k));
	}
	//returnerar ett nytt rationellt tal som är produkten av det aktuella talet och ett annat tal
	public RatNum mul(RatNum r){
		int m=r.getNumerator();
		int k=r.getDenominator();
		return new RatNum((taljare*m),(k*namnare));
	}
	//returnerar ett nytt rationellt tal som är kvoten av det aktuella talet och ett annat tal
	public RatNum div(RatNum r){
		int m=r.getNumerator();
		int k=r.getDenominator();
		return new RatNum((taljare*k),(namnare*m));
	}
	
	
	public static void main(String[] args){
		String x = "a";
		System.out.println(x.indexOf("abcd"));
	}
}
