<%@ page import="blackboard.platform.gradebook2.impl.*"%>
<%@ page import="blackboard.platform.context.*"%>
<%@ page import="blackboard.base.*"%>
<%@ page import="blackboard.persist.*"%>
<%@ page import="blackboard.platform.gradebook2.*"%>
<%@ page import="blackboard.data.course.*"%>
<%@ page import="blackboard.data.*"%>
<%@ page import="blackboard.persist.course.*"%>
<%@ page import="java.util.*"%>

<!-- User Data -->
<%@ page import="blackboard.data.user.*"%>




<%	
	//Get Student Name
	//----------------
	//initializes context
	
	ContextManagerFactory.getInstance().setContext(request);
	//Session User
	User sessionUser = ContextManagerFactory.getInstance().getContext().getUser();

	//retrieves the users first name, you can get any parameter from blackboard.data.user.User from the getUser() method.
	String firstName = sessionUser.getGivenName();
	Id sessionUserId = sessionUser.getId();
	
	
	//Set up for gradebook extraction
	//-------------------------------
	//specify the course name for which to extract the grades
	String courseIdParameter = request.getParameter("course_id");
	Id courseId = Id.generateId(Course.DATA_TYPE, courseIdParameter);
			
	//use the GradebookManager to get the gradebook data
	GradebookManager gm = GradebookManagerFactory.getInstanceWithoutSecurityCheck();
	BookData bookData = gm.getBookData(new BookDataRequest(courseId));
	List<GradableItem> lgm = gm.getGradebookItems(courseId);
	
	//it is necessary to execute these two methods to obtain calculated scores and extended grade data
	bookData.addParentReferences();
	bookData.runCumulativeGrading();
	CourseMembership cm = CourseMembershipDbLoader.Default.getInstance().loadByCourseAndUserId(courseId, sessionUserId);
%>

<!-- These lines of code are fine ^^^^^^ -->

<!DOCTYPE html>
<html>
<head>

</head>
<body>

<h1>Grade Extractor</h1><br />
<hr>
<h2>
	Hello, <% out.println(firstName);%> !
</h2>

<%
		//Arrays to contain grades for each topic
		ArrayList<Double> t1 = new ArrayList<Double>();
		ArrayList<Double> t2 = new ArrayList<Double>();
		ArrayList<Double> t3 = new ArrayList<Double>();
		ArrayList<Double> t4 = new ArrayList<Double>();
		

		//Iterate through student grades
		for (int x = 0; x < lgm.size(); x++){
// 			try{
 				GradableItem gi = (GradableItem) lgm.get(x);
 				//Prints type of score
//  				out.println(GradingSchemaDAO.get().loadById(gi.getGradingSchemaId()).getScaleType().name() + ":: ");
 				double grade = 0;
 				
 				try{
 					GradeWithAttemptScore gwas2 = bookData.get(cm.getId(), gi.getId());
 					grade = gwas2.getScoreValue();
 				}catch(NullPointerException e){
 					//No grades assigned
 					grade = 0;
 				}
 				
 				
 				//TEST
 				String title = gi.getTitle().substring(0, 1); 			// Takes first number which represents the topic
 				int topic = 0;
 				boolean isGrade = true;
 				try{
 					topic = Integer.parseInt(title);					//String to Integer for switch
 				}catch (Exception e){
 					isGrade = false;
 				}
 				
 				if(isGrade){
					switch (topic){
	 					case 1:	t1.add(grade);
	 							break;
	 					case 2:	t2.add(grade);
							break;
	 					case 3:	t3.add(grade);
							break;
	 					case 4:	t4.add(grade);
							break;
						default:
							break;
	 				}
 				}
 				
//  				out.println(gi.getTitle());
//  				out.println(": " + gwas2.getScoreValue());
//  				out.println("<br/>"); 
 				
//  			}catch(NullPointerException e){
//  				// When there is no grade assigned, there is a null pointer exception
 				
//  				out.println("I am a beautiful unicorn!<br />");
//  			}
		}
// 	}
%>

<h2>Grades Divided by Topics</h2>
<hr>

<%
	//Topic 1
	out.println("<h3>Topic 1</h3>");
	for(int i = 0; i< t1.size(); i++){
		out.println("Score: "+ t1.get(i) + "<br />");
	}
	
	//Topic 2
	out.println("<h3>Topic 2</h3>");
	for(int i = 0; i< t2.size(); i++){
		out.println("Score: "+ t2.get(i) + "<br />");
	}
	//Topic 3
	out.println("<h3>Topic 3</h3>");
	for(int i = 0; i< t3.size(); i++){
		out.println("Score: "+ t3.get(i) + "<br />");
	}
	//Topic 4
	out.println("<h3>Topic 4</>");
	for(int i = 0; i< t4.size(); i++){
		out.println("Score: "+ t4.get(i) + "<br />");
	}

%>


</body>
</html>






