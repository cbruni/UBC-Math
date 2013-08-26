//=================================================
//++++++++++++++++PIPWERKS API+++++++++++++++++++++
//++++++++++++++SCORM FUNCTIONS++++++++++++++++++++
//=================================================
        
var scorm = pipwerks.SCORM;
var lmsConnected = false;

//Error Handling
function handleError(msg){
    alert(msg);
    window.close();
}

//Initialize connection with LMS
function initCourse(){
    //scorm.init returns a boolean
    lmsConnected = scorm.init();
    
    //If scorm.init succeeds
    if (lmsConnected){
        
        //Get the completion status to see if course has already been completed
        var completionStatus = scorm.get("cmi.completion_status");
        
        //Check if course has been completed
        if (completionStatus == "completed"){
            handleError("You have already completed this course. You do not need to continue.");
        }
        
        //Obtain username from LMS
        var learnername = scorm.get("cmi.learner_name");
        //Check if name could be retrieved
        if(learnername){
            //Display name in element called "learnername"
            document.getElementById("name").innerHTML = learnername;
        }
        
    }else{ //If the course couldn't connect to the LMS
        //Alert user and close window
        handleError("Error: Course could not connect with the LMS");
    }
}

//==============================
// Setting up the Form
//==============================

function initForm(){
    document.getElementById("grade_form").onsubmit = function(){
        var score = document.getElementById("input_score").value;
        document.getElementById("box").innerHTML = "Score Set. You may close the window";
        RecordTest(score);
        return false;
    }
}

//==============================
// Set Course as Completed
//==============================


function setComplete(){
 
   //If the lmsConnection is active...
   if(lmsConnected){
 
      //... try setting the course status to "completed"
      var success = scorm.set("cmi.core.lesson_status", "completed");
 
      //If the course was successfully set to "completed"...
      if(success){
 
         //... disconnect from the LMS, we don't need to do anything else.
         scorm.quit();
 
      //If the course couldn't be set to completed for some reason...
      } else {
 
         //alert the user and close the course window
         handleError("Error: Course could not be set to complete!");
 
      }
 
   //If the course isn't connected to the LMS for some reason...
   } else {
 
      //alert the user and close the course window
      handleError("Error: Course is not connected to the LMS");
 
   }
 
}


function doUnload(pressedExit){
    
    scorm.set("cmi.exit","suspend");
    
    scorm.quit();
}


function RecordTest(score){
    scorm.set("cmi.score.raw",score);
    scorm.set("cmi.score.min","0");
    scorm.set("cmi.score.max","100");
    
    var scaledScore = score / 100;
    scorm.set("cmi.score.scaled", scaledScore);
    scorm.set("cmi.completion_status","completed");

    //50% passing grade required
    if (score >= 70){
        scorm.set("cmi.success_status","passed"); console.log("Quiz Passed")
    }else{
        scorm.set("cmi.success_status","failed");
    }
}


//==========================
// Window load functions
//==========================
window.onload = function (){
        initCourse();
        initForm();
}

window.onbeforeunload = function(){
    doUnload(false);
}

//Pressed Exit
window.onunload = function(){
    doUnload();
}