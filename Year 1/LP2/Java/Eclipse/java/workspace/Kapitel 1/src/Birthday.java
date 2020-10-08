import java.text.*;
import java.util.*;
import javax.swing.*;

public class Birthday {
	public static void main(String[] args){
		Date x = new Date();
		System.out.println(x);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String date = dateFormat.format(x);
		String month = date.substring(5,7);
		System.out.println(month);
		String day = date.substring(8,10);
		System.out.println(day);
		String personnummer=JOptionPane.showInputDialog("Ange ditt personnummer på formen YYMMDDxxxx:");
		String personmonth=personnummer.substring(2,4);
		String personday=personnummer.substring(4,6);
		if(personmonth.equals(month) && personday.equals(day)){
			JOptionPane.showMessageDialog(null, "Grattis!");
		}
	}
}
