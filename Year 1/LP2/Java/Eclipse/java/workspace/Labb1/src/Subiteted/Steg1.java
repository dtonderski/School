import static javax.swing.JOptionPane.*;

public class Steg1 {
	public static void main (String[] args){
		
		while (true) {																						//ser till så att programmet körs till man trycker på cancel eller den röda knappen

		String indata = showInputDialog("Årtal?");

		if (indata == null) {																				//stänger av programmet om cancel eller den röda knappen trycks
			System.exit(0);
		}
		
		if (indata.length()==0){																			//säger att man ska skriva ett årtal om man trycker OK utan att skriva något
			showMessageDialog(null, "Skriv ett årtal.");
			continue;
		}

		String x = indata.substring(0,1);																	//gör om det första tecknet i till en ny string (för att kolla om datumet)
		String y = indata.substring(1,indata.length());														//gör om allt förutom det första tecknet till en ny string (för att kolla om det bara är siffror efter minustecknet om det finns ett minustecken)
		if (indata.matches("[0-9]+") == false && (x.matches("-")) == false) {								//ger en error om datumet inte bara innehåller siffror och det första tecknet inte är ett minustecken
			showMessageDialog(null, "Årtalet får bara innehålla siffror och eventuellt ett minustecken.");
			continue;
		}
		if (y.matches("[0-9]+") == false && indata.length() != 1) {											//ger en error om allt förutom det första tecknet inte är siffror och längden på indatan inte är 1 (längden != 1 behövs för annars skulle årtalet 1 ge en error)
			showMessageDialog(null, "Årtalet får bara innehålla siffror och eventuellt ett minustecken.");
			continue;
		}
		if ((x.matches("-")==true) && indata.length()==1){													//ger en error om det bara är ett minustecken
			showMessageDialog(null, "Årtalet får bara innehålla siffror och eventuellt ett minustecken.");
			continue;
		}
		
		int artal=Integer.parseInt(indata);																	//kollar om året är ett skottår
		if ((( artal % 400 ) == 0) || ((artal % 4) == 0 && (artal % 100) != 0)) {
			showMessageDialog(null, "Skottår");
		}

		else {
		showMessageDialog(null, "Inte skottår");
		}
		}
	}
}