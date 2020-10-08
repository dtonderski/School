
import javax.swing.*;

public class squares extends JTextField{
	
	//initialiserar variabler f�r rader och kolumner
	private int row;
	private int column;
	
	//lägger till en konstruktor för squares
	public squares(int r, int c){
		row = r;
		column = c;
	}
	//lägger till get-metoder
	public int getRow(){
		return row;
	}
	
	public int getColumn(){
		return column;
	}
}
