public class Sort {
	public static void sortArray(int[] a){
		int i;
		int n;
		while(true){
			int m=a.length;
			i = 0;
			n = 0;
			for(i=0;i<(m-1);i++){
				if(a[i]>a[i+1]){
					int k = a[i];
					a[i]=a[i+1];
					a[i+1]=k;
					n=n+1;
				}
			}
			if(n==0){
				System.out.println("Arrayen är sorterad!");
				break;
			}
		}
	}
	public static void main(String[] args){
		int x[]={1,2,3,5,1,4,100,123,134,1234,345,34,124,453,6,7,2,354,2314,234,456,6,6,7,8,546,456,6,78,56,8,8,8,56,56,7,567};
		sortArray(x);
		for(int i=0;i<x.length;i++){
			System.out.println(x[i]);
		}

	}
}