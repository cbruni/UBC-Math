package courseClasses;

public class Test {
	String name;
	double grade;
	
	//Constructor
	public Test(String inputName, double inputGrade){
		name = inputName;
		grade = inputGrade;
	}
	public Test(){
		name = null;
		grade = 0;
	}
	
	//Get Methods
	public double getGrade(){
		return grade;
	}
	public String getName(){
		return name;
	}
	public double getPercent(double total){
		double percent = (grade/total)*100;
		return percent;
	}
	 //Set Methods
	public void setGrade (double inputGrade){
		grade = inputGrade;
	}
	public void setName(String inputName){
		name = inputName;
	}
}
