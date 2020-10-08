import java.awt.*;
import java.awt.event.*;

import javax.swing.*;
import javax.swing.border.*;
public class Tangentbord extends JFrame implements ActionListener {
	private String[] knappMonster = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "+", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "Å", "A", "S", "D", "F", "G", "H", "J", "K", "L", "Ö", "Ä", "Z", "X", "C", "V", "B", "N", "M", ",", ".", "-"};
	private JTextField text = new JTextField();
	private JButton spacebar = new JButton(" ");
	private JButton delete = new JButton("delete");
	
	public void actionPerformed(ActionEvent e){
		if(e.getSource()==delete){
			if(text.getText().length()>0){
				text.setText(text.getText().substring(0,text.getText().length()-1));

			}
		}
		else{
			JButton temp = (JButton) e.getSource();
			text.setText(text.getText() + temp.getText());
		}

	}
	
	public Tangentbord(){
		setLayout(new BorderLayout());
		add(text, BorderLayout.NORTH);
		JPanel buttons = new JPanel(new GridLayout(4,11));
		for(int i = 0; i<knappMonster.length; i++){
			JButton knapp = new JButton(knappMonster[i]);
			buttons.add(knapp);
			knapp.addActionListener(this);
		}
		add(buttons, BorderLayout.CENTER);
		JPanel bottom = new JPanel(new FlowLayout());
		bottom.add(spacebar);
		bottom.add(delete);
		spacebar.setPreferredSize(new Dimension(((bottom.getHeight()*4)/10), bottom.getWidth()));
		spacebar.addActionListener(this);
		delete.addActionListener(this);
		add(bottom, BorderLayout.SOUTH);
		setSize(1000,400);
		setDefaultCloseOperation(EXIT_ON_CLOSE);
		setVisible(true);


	}
	public static void main(String[] args){
		new Tangentbord();
	}
	
	
}
