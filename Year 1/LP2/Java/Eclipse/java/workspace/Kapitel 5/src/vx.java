import java.io.*;
import java.util.*;
public class vx {
	public static void main(String[] args){
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		System.out.print("Ange pris samt belopp: "); System.out.flush();
		try{
			String indata = in.readLine();
			Scanner sc = new Scanner(indata);
			String Pris = sc.next();
			String Belopp = sc.next();
			int pris=Integer.parseInt(Pris);
			int belopp=Integer.parseInt(Belopp);
			int vaxel = belopp - pris;
			if(vaxel<0){
				System.out.println("Inte tillräckligt med pengar!");
				return;
			}
			if(vaxel==0){
				System.out.println("Ingen växel!");
				return;
			}
			int hundralappar = vaxel/100;
			vaxel=vaxel-100*hundralappar;
			int femtio = vaxel/50;
			vaxel=vaxel-50*femtio;
			int tjugo = vaxel/20;
			vaxel=vaxel-20*tjugo;
			int tio = vaxel/10;
			vaxel=vaxel-10*tio;
			int fem = vaxel/5;
			vaxel=vaxel-5*fem;
			int ettor = vaxel;
			System.out.println(hundralappar + " hundralappar, " + femtio + " femtiolappar, " + tjugo + " tjugolappar, " + tio + " tiokronorsmynt, " + fem + " femkronorsmynt samt " + vaxel + " enkronor.");
		}
		catch (InputMismatchException e1) {
			System.out.println("InputMismatchException: " + e1.getMessage());
		}
		catch (NoSuchElementException e2) {
			System.out.println("NoSuchElementException: " + e2.getMessage());
		}
		catch (NumberFormatException e3){
			System.out.println("NumberFormatException: " + e3.getMessage());
		}
		catch (IOException e4){
			System.out.println("IOException: " + e4.getMessage());
		}

	}
}
			
			