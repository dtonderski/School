import java.lang.*;
import java.util.ArrayList;
import java.util.List;
public class vektor{
	public static double length(List<Double> l) {
		double v = 0;
		for(double s: l)
			v=v+s*s;
		return Math.sqrt(v);
	}
	public static void main(String[] args){
		List<Double> l = new ArrayList<>();
		l.add((double)3);
		l.add((double)4);
		l.add((double)123);
		System.out.println(length(l));
	}
}