import java.io.*;
import java.util.*;
public class info {
	public static void main(String[] args) throws UnsupportedEncodingException, FileNotFoundException, IOException{
		BufferedReader inFil= new BufferedReader(new FileReader("information.txt"));
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		System.out.println("Namn? ");
		String namn = in.readLine();
		PrintWriter utFil = new PrintWriter(new BufferedWriter(new FileWriter(namn)));
		while(true){
			String rad1=inFil.readLine();
			String rad2=inFil.readLine();
			if(rad1==null){
				break;
			}
			Scanner sc = new Scanner(rad2);
			sc.next();
			int l = Integer.parseInt(sc.next());
			if(l>=200){
				utFil.println(rad1);
				System.out.println(rad1);
				utFil.println(rad2);
				System.out.println(rad2);
			}
		}
		utFil.close();

	}
}
