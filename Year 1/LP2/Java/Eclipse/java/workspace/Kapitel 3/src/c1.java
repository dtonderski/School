import javax.swing.*;
import java.lang.*;

public class c1 {
	public static double a(int x){
		double g = x/2;
		double h = x/g;
		double gn;
		double y=Math.abs(g*g-x);
		while(y>0.000006){
			gn=g;
			g=(gn+h)/2;
			h=x/g;
			y=Math.abs(g*g-x);
		}
		return g;
	}
	public static void main(String[] args){
		System.out.println(a(2));
	}
}
