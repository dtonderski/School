import java.io.BufferedReader;
import java.io.Console;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Locale;
import java.util.NoSuchElementException;
import java.util.Scanner;

public class Uppgift1 {
	public static void main(String[] args){
		while(true){
			try{
		
			BufferedReader in= new BufferedReader(new InputStreamReader(System.in));
			System.out.println("Skriv indata: ");
			String s = in.readLine();
			Scanner sc = new Scanner(s);
			String Mil1 = sc.next();
			String Mil2 = sc.next();
			String Bensin = sc.next();
			int mil = Integer.parseInt(Mil2) - Integer.parseInt(Mil1);
			double bensin = Double.parseDouble(Bensin);
			double f = mil/bensin;
			System.out.printf(new Locale("sv", "SE"), "Antal körda mil:\t%d\nAntal liter bensin:\t%.1f \nFörbrukning per mil:\t%.2f", mil, bensin, f);
		}
        catch (NumberFormatException e) {
            System.out.println("NumberFormatException: " + e.getMessage());
        }
		catch (IOException b){
			System.out.println("IOexception: " + b.getMessage());
		}
		catch (NoSuchElementException c){
			System.out.println("NoSuchElementException: " + c.getMessage());
		}
		
		
	}
	}
}
