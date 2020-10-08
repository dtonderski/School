

public class Move {
	//initialiserar de fyra variablerna
	private int oldValue;
	private int newValue;
	private int row;
	private int col;
	//konstruktor för ett nytt drag
	public Move(int old, int New, int r, int c){
		oldValue=old;
		newValue=New;
		row=r;
		col=c;
		
	}
	
	//lägger till get-metoder
	public int getOldValue(){
		return oldValue;
	}
	
	public int getRow(){
		return row;
	}
	
	public int getColumn(){
		return col;
	}
	
	public int getNewValue(){
		return newValue;
	}
}
