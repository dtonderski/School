public class b{
	public static void Rotate(Object[] x, int r){
		int m=x.length;
		while(r>m){
			r=r-m;
			System.out.println(r);
		}
		Object[] b = new Object[m];
		System.arraycopy(x, 0, b, 0, m);
		
		for(int i=m-1; i>r-1; i--){
			x[i]=x[i-r];
		}
		for(int i=0; i<r; i++){
			x[i]=b[m-r+i];
		}
	}
	public static void main(String[] args){
		Object[] a = {1, 2, 3, 4};
		Rotate(a,123);
		for(int i=0;i<(a.length); i++){
			System.out.println(a[i]);
		}
		
	}
}