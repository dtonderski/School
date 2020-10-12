numberOfHiddenNeurons = 7;
chromosome = [0.797783419518556,4.67385943403100,-3.66704348148664,4.59051248096142,3.78695321404211,-1.22649028743126,-3.66041645620776,3.13487182098097,4.87302788651413,-3.43464447416648,-4.83125219352798,-2.80506286277784,0.0704200167288178,2.02307521522543,-1.00878890351195,3.20147288359437,-0.361408370541643,2.00083652964082,-0.266648460025188,-0.920307258129922,2.26064399662166,2.60318098234208,-2.83819668957297,1.01450594042379,-1.97854138354459,1.28982341688206,-1.18711754613926,-4.99084524211914,-2.74894463300532,-2.87149281477219,2.78557755433328,1.70879682421462];
DriveTruckVisualize(chromosome, numberOfHiddenNeurons, 1, 3);
GetFitness(chromosome, numberOfHiddenNeurons, 1)

%%
chromosome = [-4.64768610257544,-6.55125113640907,7.93756227731633,-3.04250923851323,-2.67479620152094,3.10911570394846,2.13932926035030,3.33800780860174,-3.18502310387101,-2.57548723383020,-8.41536335533354,7.84036259423163,-8.80790915113622,1.72057843815661,1.51566959317684,10.1306538991901,9.11329366650942,-5.57088602465368,7.17180898921216,8.49599667141656,-3.72191704466797,-5.93174566256005,-2.39281138923436,-10.1717946970897,4.59999521613956,-9.61158105209814,-5.46931305468598,-7.01682733289484,-8.45175637617086,0.459841999718337,-11.7889945019011,4.07270610313162,-7.43452519275009,1.32864775444120,2.80726147171635,3.76992554918670,7.82131570752298,5.21006051833704,7.37830702561403,-10.0234183539646,-0.653228392605258,-5.82632970574178,0.499017424087006,6.06949392946554];
GetValidationFitness(chromosome, numberOfHiddenNeurons, 3)
