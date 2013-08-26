package courseClasses;

import java.util.ArrayList;

public class Topic {

	String name;
	ArrayList<Test> sections;
	
	public Topic(String inputName){
		name = inputName;
		sections = new ArrayList<Test>();
	}
	public Topic(){
		name = "unassigned";
		sections = new ArrayList<Test>();
	}
	
	//Get Methods
	public String getName(){
		return name;
	}
	public Test getSection(int index){
		return sections.get(index);
	}
	public int getSectionLength(){
		return sections.size();
	}
	
	//Set Methods
	public void setName(String inputName){
		name = inputName;
	}
	
	//Other Methods
	public void add(Test section){
		sections.add(section);
	}
	public void remove(int index){
		sections.remove(index);
	}
	//Other Methods
	public double avgGrade(){
		double avgGrade = 0;
		
		for(int i=0; i < sections.size(); i++){
			avgGrade += sections.get(i).getGrade();
		}
		avgGrade = avgGrade/sections.size();
				
		return avgGrade;
	}
	
	
}
