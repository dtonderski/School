public class c {
	static int antal=0;
	public static int totAntal(){
		return antal;
	}
	public c(){
			antal=antal+1;
	}
	public static void main(String[] arg){
		c x= new c();
		c y=new c();
		System.out.println(c.totAntal());
		int m = -123;
		System.out.println(Math.abs(m));
	}
}
