import java.util.*;
import java.io.*;
public class renta{
	public static void main(String[] args){
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		System.out.println("Ange kapital samt renta");
		try{
			String indata = in.readLine();
			Scanner sc = new Scanner(indata);
			String Kapital = sc.next();
			String Renta = sc.next();
			double kapital = Double.parseDouble(Kapital);
			double renta = Double.parseDouble(Renta);
			for(int i=1;i<11;i++){
				kapital=kapital+kapital*(renta/100);
				System.out.printf("Kapitalet efter %d år är %.2f kr.\n", i, kapital);
			}
		}
		catch(NumberFormatException e1){
			System.out.println("NumberFormatException: " + e1.getMessage());
		}
		catch(IOException e2){
			System.out.println("IOException: " + e2.getMessage());
		}
		catch(InputMismatchException e3){
			System.out.println("InputMismatchException: " + e3.getMessage());
		}
		catch(NoSuchElementException e4){
			System.out.println("NoSuchElementException: " + e4.getMessage());
		}
	}
}
		