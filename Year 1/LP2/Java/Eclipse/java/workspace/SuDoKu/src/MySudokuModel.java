
import java.beans.*;
import java.util.*;

public class MySudokuModel implements SudokuModel{
	
	
	//lägger till PropertyChangeSupport, addPropertyChangeListener och removePropertyChangeListener
	private final PropertyChangeSupport pcs = new PropertyChangeSupport(this);
	
	public void addPropertyChangeListener(PropertyChangeListener l){
		pcs.addPropertyChangeListener(l);
	}
		
	public void removePropertyChangeListener(PropertyChangeListener l){
		pcs.removePropertyChangeListener(l);
	}
	
	//array med värden för rutorna
	private int[][] m = new int[9][9];
	
	//konstruktor som sätter alla rutor till 0
	public MySudokuModel(){
		for (int r=0; r<9; r++){
			for(int k=0; k<9; k++){
				m[r][k]=0;
			}
		}	
	}
	
	//skapar en ny modell genom att sätta alla rutor till samma värde som i modellen i parametern
	public MySudokuModel(MySudokuModel f){
		for (int r=0; r<9; r++){
			for(int k=0; k<9; k++){
				m[r][k]=f.getBoard(r,k);
			}
		}	
	}
	

	
	//Gör samma sak som getBoard
	@Override
	public String toString(){
		return getBoard();
	}
	
	

	//sätter alla rutor till 0 och kör firePropertyChange
	public void clear(){
		String oldValue = this.toString();
		for (int r=0; r<9; r++){
			for(int c=0; c<9; c++){
				m[r][c]=0;
			}
		}	
		String newValue = this.toString();
		pcs.firePropertyChange("Modell", oldValue, newValue);
	}
	

	//försöker sätta rutan till det angivna värdet, och i så fall kör fireIndexedPropertyChange

	public void setBoard(int row, int column, int value){

		if(isLegal(value, row, column)){
			int oldValue = m[row][column];
			m[row][column]=value;
			int newValue=m[row][column];
			pcs.fireIndexedPropertyChange("Value", 9*row+column, oldValue, newValue);
		}

	}
	

	
	//Metod som kollar om man får sätta in värdet value i den angivna raden och kolumnen
	public boolean isLegal(int value, int row, int column){
		for(int i=0;i<9;i++){
			//kör igenom alla värden för den angivna raden och kollar om något är samma som värdet value, om det inte är på samma plats så returneras false
			if(m[row][i]==value && i!=column && m[row][i]!=0){
				return false;
			}
			//kör igenom alla värden för den angivna kolumnen och kollar om något är samma som värdet value, om det inte är på samma plats så returneras false
			if(m[i][column]==value && i!=row && m[i][column]!=0){
				return false;
			}
		}
		//blocken numreras på följande sätt:
		//(0,0) (0,1) (0,2)
		//(1,0) (1,1) (1,2)
		//(2,0) (2,1) (2,2)
		//rad2 är den första "koordinaten", kol2 är den andra "koordinaten"
		//rad2 är alltså antalet gånger som tre går in i rad
		//kol2 är antalet gånger som tre går in i column
		int row2=((row)-(row)%3)/3;
		int col2=(column-column%3)/3;
		//värdena som behöver kollas är alltså de vars rad är från rad2*3 till rad2*3 +3 och de vars column är från column2*3 till column2*3 + 3
		for(int r=(0+row2*3);r<(3+row2*3);r++){
			for(int c = (0+col2*3); c<(3+col2*3); c++){
				if(m[r][c]==value && r!=row && c!=column && m[r][c]!=0){
					return false;
				}
			}
		}
		return true;
	}
	
	//"kopierar" en annan bräda (utan att kolla isLegal, användbart i MySudokuController (knappen New))
	public void setBoard(MySudokuModel model){
		for (int r=0; r<9; r++){
			for(int k=0; k<9; k++){
				m[r][k]=model.getBoard(r,k);
			}
		}
	}
	
	
	
	//sätter spelet till det som anges i stringen som anges som parameter
	public void setBoard(String s) throws IllegalArgumentException{
		//sparar det gamla värdet
		String oldValue= this.toString();
		//kastar en ny IllegalArgumentException om stringen är tom
		if(s==null || s.isEmpty()){
			throw new IllegalArgumentException("Stringen är tom!");
		}
		//skapar en array av strings, där varje element är en rad
		String rows[] = s.split("\\n");
		//om det inte är 9 rader, så kastas en ny IllegalArgumentException
		if(rows.length!=9){
			throw new IllegalArgumentException("Fel format!");
		}
		
		//om varje rads längd inte är 9, så kastas en ny IllegalArgumentException
		for(int i=0;i<9;i++){
			if(rows[i].length()!=9){
				throw new IllegalArgumentException("Fel format!");
			}
		}
		
		//Om tecknet inte är blankt så försöker den sätta in det i rätt ruta
		for (int r=0; r<9; r++){
			for(int k=0; k<9; k++){
				char character = rows[r].charAt(k);
				String symbol = Character.toString(character);
				if(symbol.matches("[0-9]+")){
					int value=Integer.parseInt(symbol);
					if(isLegal(value, r,k)){
						m[r][k]=value;
					}
					else{
						throw new IllegalArgumentException("Olagligt värde");
					}
				}
				else{
					m[r][k]=0;
				}
			}	
		}
		//sparar det nya värdet
		String newValue=this.toString();
		//kör firePropertyChange
		pcs.firePropertyChange("Modell", oldValue, newValue);
		
	}
	
	
	

	//returnar värdet i den angivna raden och columnen
	public int getBoard(int rad, int column){
		return m[rad][column];
	}
	


	//ger en string som beskriver spelplanet genom att för varje rad i sudokut lägga till alla värdena i raden i sudokut och sedan byta till nästa rad i stringen
	public String getBoard(){
		String wholeBoard = "";
		for(int i=0; i<9; i++){
			for(int p=0; p<9; p++){
				wholeBoard=wholeBoard + Integer.toString(m[i][p]);
				}
			wholeBoard = wholeBoard + "\n";
			}
		return wholeBoard;
	}
	


	//hittar vilken cell som har minst antal nollor i block, kolumn o rad
	public int[] squareZeroMin(){
		//hittar hur många nollor det finns i varje block
		int zerosInBlocks[][]= new int[3][3];
		for(int blockRow=0;blockRow<3;blockRow++){
			for(int blockColumn=0;blockColumn<3;blockColumn++){
				for(int rad=blockRow*3; rad<blockRow*3+3; rad++){
					for(int col=blockColumn*3; col<blockColumn*3+3;col++){
						if(m[rad][col]==0){
							zerosInBlocks[blockRow][blockColumn]++;
						}
					}
				}
			}
		}
		int zerosInRow[]= new int[9];
		int zerosInCol[] = new int[9];
		
		//hittar hur många nollor det finns i varje rad och kolumn
		for(int r=0; r<9;r++){
			for(int c=0; c<9;c++){
				if(m[r][c]==0){
					zerosInRow[r]++;
					zerosInCol[c]++;
				}
			}
		}
		
		//skapar arrayen zeros genom att lägga ihop zerosInCol, zerosInRow och zerosInBlocks för varje ruta som är 0
		int blockColumn=0;
		int blockRow=0;
		int zeros[][] = new int[9][9];
		for(int r=0; r<9;r++){
			for(int c=0; c<9;c++){
				if(m[r][c]==0){
					blockColumn= (c-c%3)/3;
					blockRow=(r-r%3)/3;
					zeros[r][c]=zerosInRow[r]+zerosInCol[c]+zerosInBlocks[blockRow][blockColumn];
				
				}
			}
		}
		
		//sätter colZerosMin och rowZerosMin till den första rutan som har en nolla
		int colZerosMin=0;
		int rowZerosMin=0;
		loop:
		for(int r=0; r<9;r++){
			if(zerosInRow[r]!=0){
				for(int c=0;c<9;c++){
					if(zerosInCol[c]!=0){
						if(m[r][c]==0){
							rowZerosMin=r;
							colZerosMin=c;
							break loop;
						}
					}
				}
			}
		}
		
		//sätter colZerosMin och rowZerosMin till den rutan som har minst nollor
		for(int r=0;r<9;r++){
			for(int c=0; c<9;c++){
				if(m[r][c]==0){
					if(zeros[r][c]<zeros[rowZerosMin][colZerosMin]){
						rowZerosMin=r;
						colZerosMin=c;
					}
				}
			}
		}
		
		int[] squareZerosMin= {rowZerosMin, colZerosMin};
		return squareZerosMin;
	}
	
	//inten i behövs för att kolla om lösningen är unik
	private int i = 0;
	


	//löser sudokut
	public boolean solve(boolean notUnique){


		//om AntalNollor=0 return true
		int zeros = 0;
		for(int r=0; r<9;r++){
			for(int k=0;k<9;k++){
				if(m[r][k]==0){
					zeros++;
				}
			}
		}
		if(!notUnique){
			if(zeros==0){
				pcs.firePropertyChange("Modell",null, this.toString());
				return true;
			}
		}
		else{
			if(zeros==0 && i!=0){
				//om det är den andra hittade lösningen, returna true
				return true;
			}
			
			
			
			if(zeros==0 && i==0){
				//om det är den första hittade lösningen, så returna false
				i++;
				return false;
			}
		}

		
		int[] squareZerosMin = squareZeroMin();
		int rowZerosMin=squareZerosMin[0];
		int colZerosMin=squareZerosMin[1];
		
		//löser sudokut genom rekursion
		for(int number=1;number<=9;number++){
			if(isLegal(number, rowZerosMin, colZerosMin)){
				m[rowZerosMin][colZerosMin] = number;
				if(solve(notUnique)){
					return true;
				}			
			}
		}
		m[rowZerosMin][colZerosMin] = 0;
		return false;
	}
	
	

	//löser sudokut
	public boolean solve(){
		return solve(false);
	}
	

	



	
	//kollar om Sudokut går att lösa genom att köra solve på en kopia
	public boolean isSolvable(){
		MySudokuModel copy = new MySudokuModel(this);
		return copy.solve();
	}

	
	
	//Kollar om sudokut går att solva, om det gör det så kollar den om den har mer än en lösning, om den har mer än en lösning så return false, om den har en lösning så return true, om den saknar lösning så return false
	public boolean isUnique(){
		MySudokuModel copy = new MySudokuModel(this);
		if(this.isSolvable()){
			if(copy.solve(true)){
				return false;
			}
			else{
				return true;
			}
		}
		else{
			return false;
		}
	}
}