import static javax.swing.JOptionPane.showInputDialog;
import static javax.swing.JOptionPane.showMessageDialog;

public class Steg3 {
		public static void main (String[] args){
			while (true) {																				//ser till så att programmet körs till man trycker på cancel eller den röda knappen
			String x = showInputDialog("Skriv ett datum på formen åååå-mm-dd");
			if (x == null) {																			//stänger av programmet om cancel eller den röda knappen trycks
				System.exit(0);
			}
			
			if (x.length()==0){																			//säger att man ska skriva ett datum om man trycker OK utan att skriva något
				showMessageDialog(null, "Skriv ett datum.");
				continue;
			}
			
			if (x.length() != 10){																		//kollar om datumet är på rätt form
				showMessageDialog(null, "Skriv datumet på formen åååå-mm-dd.");
				continue;
			}
			
		String indata = x.substring(0,4);																//gör om de första fyra siffrorna i datumet till en ny string
		
		
		
		if (indata.matches("[0-9]+") == false) {														//kollar vidare om datumet är på rätt form
			showMessageDialog(null, "Skriv datumet på formen åååå-mm-dd.");
			continue;
		}
		
		if (x.substring(5,7).matches("[0-9]+") == false) {
			showMessageDialog(null, "Skriv datumet på formen åååå-mm-dd.");
			continue;
		}
		
		if (x.substring(8,10).matches("[0-9]+") == false) {
			showMessageDialog(null, "Skriv datumet på formen åååå-mm-dd.");
			continue;
		}
		
		
		int artal=Integer.parseInt(indata);																//gör om årtalet, månadens och dagens nummer till integers
		int månad = Integer.parseInt(x.substring(5,7));
		int dag = Integer.parseInt(x.substring(8,10));
		
		
		if (!(("-").equals(x.substring(4,5)))){															//kollar vidare om datumet är på rätt form
			showMessageDialog(null, "Skriv datumet på form åååå-mm-dd.");
			continue;
			
		}
		if (!(("-").equals(x.substring(7,8)))){
			showMessageDialog(null, "Skriv datumet på form åååå-mm-dd.");
			continue;
			
		}
		
		
		
		if (artal<1754){
			showMessageDialog(null, "Programmet fungerar bara för datum efter år 1753");
			continue;
		}
		if (månad<1 || månad>12){
			showMessageDialog(null, "Välj en månad mellan 01 och 12");
			continue;
		}
		if (dag<1 || dag>31){
			showMessageDialog(null, "Välj en dag mellan 01 och 31");
			continue;
		}
		if (dag==31 && (månad==2 || månad == 4 || månad == 6 || månad == 9 || månad == 11)) {
			showMessageDialog(null, "Din valda månad har inte 31 dagar");
			continue;
		}
		int[] månader;																					//gör en lista som ska innehåller månadernas dagar
		månader = new int[13];
		
		if ((( artal % 400 ) == 0) || ((artal % 4) == 0 && (artal % 100) != 0)){						//bestämmer om februari har 28 eller 29 dagar det valda året
			int skottar= 1;
			månader[2]=28+skottar;
		}
		else {
		int skottar = 0;
		månader[2]=28+skottar;
		}
		
		if((månader[2]!=29) && (månad==2) && (dag>28)){													//kollar om februari har 29 dagar det valda året om datumet är den 29 februari
			showMessageDialog(null, "Februari har bara 28 dagar detta år!");
			continue;
		}
		månader[1]=31;																					//gör klart listan med månadernas dagar
		månader[3]=31;
		månader[5]=31;
		månader[7]=31;
		månader[8]=31;
		månader[10]=31;
		månader[12]=31;
		månader[4]=30;
		månader[6]=30;
		månader[9]=30;
		månader[11]=30;
		int DagNummer=dag;																				//räknar hur många dagar har passerat det valda året
		for (int i = 1; i<månad; i++) {
		DagNummer = DagNummer + månader[i];
		}
		int Dagar = 0;
		for (int i =1754; i<artal; i++) {																//räknar hur många dagar har passerat sedan 1 januari 1754 till början av det valda året
		if (( i % 400 ) == 0) {
			Dagar = Dagar + 366;
		}
		else if (( i % 100) == 0) {
			Dagar = Dagar + 365;
		}
		else if (( i % 4) == 0) {
			Dagar = Dagar + 366;
		}
		else {
			Dagar = Dagar + 365;
		}
		}
		int Dagartotal = Dagar + DagNummer;																//räknar ihop hur många dagar sammanlagt har passerat sedan 1 januari 1754
		int k=Dagartotal%7;																				//kollar resten av dagarnas antal delat med 7
		String[] veckodagar;																			//gör en lista med veckodagar (listan börjar med en tisdag eftersom 1 januari 1754 var en tisdag)
		veckodagar = new String[7];
			veckodagar[1]="tisdag";
			veckodagar[2]="onsdag";
			veckodagar[3]="torsdag";
			veckodagar[4]="fredag";
			veckodagar[5]="lördag";
			veckodagar[6]="söndag";
			veckodagar[0]="måndag";
		showMessageDialog(null, "Det är en " + veckodagar[k]);											//skriver ut vilken veckodag det valda datumet är

		}

		
	}
}