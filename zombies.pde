PFont font;

color good =  color(0, 255, 0); //Healthy
color hurt = color(255, 255, 0); //Injured
color zombie = color(255, 0, 0); //Infected

int healthySpeedX = 4;
int healthySpeedY = 3;
int injuredSpeedX = 2; //Different speeds
int injuredSpeedY = 3;
int zombieSpeedX = 3;
int zombieSpeedY = 3;


class survivor
{
  int circleX;    
  int circleY;            //class for the survivors
  int cirlcDimensions;
  int bullets = int(random(0, 20));   //random amount of bullets ranging from 0 to 20 for each person
  boolean infected = false;
  boolean injured = false;   //booleans for the injured and the infected
  int t;
  String[] survivorNames = {
    "Adam", "Sarah", "Naruto", "Kate", "Athena", "Sasuke", "Rico", "Niko"
  }; //array for the names
  int healthyOrNot = int(random(50));   //set up a "chance" typr of variable to determin wether or not the person is infected, injured or healthy

  survivor(int CX, int CY, boolean inf, boolean inj, int t)
  {
    circleX = CX;                  
    circleY = CY;                //constructure
    cirlcDimensions = 30; 
    infected = inf;
    injured = inj;
    this.t = t;
  }

  void drawPeople()        //function to draw
  {
    if (healthyOrNot < 30 && healthyOrNot > 20)
    {
      infected = true;     //The person will be zombie
      fill(zombie);
    }
    if (healthyOrNot <= 20)
    {
      injured = true;        //The person ill be injured
      fill(hurt);
    }
    if (healthyOrNot >= 30)
    {
      infected = false;    //The person will be healthy
      injured = false;
      fill(good);
    }

    int r = survivorNames.length;
    ellipse(circleX, circleY, cirlcDimensions, cirlcDimensions);  //draw the ellipse

    fill(0);
    text(survivorNames[t], circleX, circleY + cirlcDimensions);   //Draw the text of the names and the amount of bullets
    text(bullets, circleX, circleY + (cirlcDimensions + 20));
  }

  void mouvement(survivor[] survivors)
  {
    float angle;
    int i = 0;
    constrain(circleX,0, width);
    constrain(circleY,0,height);
    while (i < survivors.length)
    //Movement for healthy survivors
    {
      if (infected == false)  
      {
        if(survivors[i].infected == true)
        {
          //Distance between each healthy and infected
          if((dist(circleX,circleY,survivors[i].circleX,survivors[i].circleY) < 50))
          {
                    
          //calculate angles between circles
          angle = atan2(circleY - survivors[i].circleY, circleX - survivors[i].circleX);
          if(injured == true) //If they are injured
          {
          circleX+= cos(angle) * (injuredSpeedX); 
          circleY+= sin(angle) * (injuredSpeedY);
          }
          else //If they are healthy
          {
          circleX+= cos(angle) * (healthySpeedX);
          circleY+= sin(angle) * (healthySpeedY);
          }
         }
        else
        {
          circleX += healthySpeedX;
          circleY += healthySpeedY;
        }  
       }
     } 
     else
     {
       //Movement for zombies        
       if (survivors[i].infected == false)
       {
          //Calculate angle between circles
         angle = atan2(circleY - survivors[i].circleY, circleX - survivors[i].circleX);
         circleX+= cos(angle + PI) * (zombieSpeedX);
         circleY+= sin(angle + PI) * (zombieSpeedY);        
       }
     }      
    i++;
    }
  }
  
 boolean checkCollision (survivor[] survivors) //Check collision function
 {
   boolean checkCollision  = false; //Set it initially to false
   int index = 0;
   while (index < survivors.length)
   {
     if((dist(circleX,circleY,survivors[index].circleX,survivors[index].circleY) < cirlcDimensions)) //If the circles touch
     {
       checkCollision = true; //Collision is true
     }
   }
   return checkCollision; //It will return it
 }

}
survivor[] survivors = new survivor[8]; 

  void setup()
  {
    size(600, 600);
    background(214, 179, 110);
    rectMode(CENTER);
    ellipseMode(CENTER);
    textAlign(CENTER, CENTER);


    int spacePeople = width/survivors.length;  
    int i = 0;
    while (i < 8)
    {                         //While loop to draw the people
      int x = spacePeople*(i) + (spacePeople / 2);                   
      survivors[i] = new survivor(int(random(50, 500)), int(random(50, 500)), false, false, i);   //Object instance 
      survivors[i].drawPeople();               
      i++;
    }  
    font = loadFont("YuMincho-Demibold-35.vlw");
  }

  void draw()
  {
    background(214, 179, 110);
    text("Percentage Of Survivors: " + survivors(survivors) + "%", 100, 20);       //Prints the percentage of healthy people left
    text( "Total Bullets Carried By Non Infected: " + bullets(survivors), 133, 40); //Prints the amount of bullets the healthy people are holding  
    int spacePeople = width/survivors.length;  
    int i = 0;
    while (i < 8)
    {                         //While loop to draw the people
      int x = spacePeople*(i) + (spacePeople / 2);                   
      survivors[i].drawPeople();      
      survivors[i].mouvement(survivors);   
      i++;
    }
  }

  int bullets(survivor[] j)   //Function fot the amount of bullets left
  {
    int totalbullets = 0;

    for (int i =0; i < j.length; i++)
    {
      if ((j[i].infected == false) &&  (j[i].injured == false)) 
      {
        totalbullets += j[i].bullets;
      }
    }
    return totalbullets;
  }

  int survivors(survivor[] s)   //Funtion for the percentage of survivors
  {
    float zero = 0.0;
    int percent;
    for (int i = 0; i < s.length; i++)    
    {
      if ((survivors[i].infected == false)  && (survivors[i].injured == false))
      {
        zero ++;
      }               //If the person is healthy it will count them as a survivor
    }
    percent = (int)(zero / float(s.length)  * 100);  //Equation to get the persentage
    return percent;
  }  

