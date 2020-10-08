import javax.swing.*;
public class Euklides{
	public static int sgd(int x, int y){
		int r = x%y;
		if(r==0){
			return y;
		}
		while(true){
			x=y;
			y=r;
			r=x%y;
			if(r==0){
				return y;
			}
		}
	}
	public static void main(String[] arg){
		System.out.println(sgd(1,1));
		while(true){
			String m = JOptionPane.showInputDialog("Det första talet:");
			if(m==null){
				break;
			}
			String n = JOptionPane.showInputDialog("Det andra talet:");
			if(n==null){
				break;
			}
			int x = Integer.parseInt(m);
			int y = Integer.parseInt(n);
			JOptionPane.showMessageDialog(null, sgd(x,y));
		}
	}
}