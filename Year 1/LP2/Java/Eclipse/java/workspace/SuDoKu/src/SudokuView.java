
import java.beans.*;
import javax.swing.*;

public abstract class SudokuView extends JPanel implements PropertyChangeListener{
	protected SudokuModel model;
	public SudokuModel getModel(){
		return model;
	}
	public void setModel(SudokuModel m){
		if(model!=null)
			model.removePropertyChangeListener(this);
		model=m;
		if(model!=null)
			model.addPropertyChangeListener(this);
	}
	
	public void propertyCHange(PropertyChangeEvent e){
		repaint();
	}
}
