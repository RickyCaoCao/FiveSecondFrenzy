//will need to collision and bounce between enemy boxes
//I'm not sure if the keyReleased and keyPressed funtions only work for this level or work for all levels
//Is there are "keyrelease" variable??? If yes, then I can place the movement within another function

//keeps track of all the boxes
ArrayList <Boxes> enemyBoxes = new ArrayList <Boxes> ();

//creates a box controlled by the player
Boxes playerBox;

//stores the movement of the player-controlled box
float velX = 0;
float velY = 0;

//will show defeat screen if true
boolean defeat = false;

void LevelTwo() {
  //continues game until a victory or defeat is broadcasted
  if (!levelComplete) {
    //will create game elements one time
    if (enemyBoxes.size() == 0) {
      //create the box the player controls
      playerBox = new Boxes();

      //centers it on screen
      playerBox.center();

      //changes the color to blue
      playerBox.changeToFriendly();

      //constrains playerBox

      //creates all the enemy boxes
      for (int i = 0; i < 25; i++) {
        Boxes aNewBox = new Boxes();
        enemyBoxes.add(aNewBox);
      }
    }
    //refreshes screen
    background(255);
    
    //gives instruction to the player
    textAlign(CENTER);
    fill(5, 70, 255);
    text("Avoid the Green Boxes!", width/2, height/2 - 150);

    //moves and displays all enemy boxes
    moveEnemyBoxes();
    displayEnemyBoxes();

    //display player box and moves it
    playerBox.display();
    movePlayerBox();

    //check for collision between enemy box and player's box
    for (Boxes item : enemyBoxes) {
      //collision system
      if ((item.x + 10) > (playerBox.x - 10) && (item.y + 10) > (playerBox.y - 10) && (playerBox.x + 10) > (item.x - 10) && (playerBox.y + 10) > (item.y - 10)) {
        defeat = true;
        break;
      }
    }

    //draws timer
    Timer();

    //continues the reset timer until level complete
    resetTimer = millis();
  }

  //shows victory when player has avoided the boxes for 5 seconds  
  if (millis() - currentTimer >= 5000) {
    Victory();
    if (millis() - resetTimer >= 2000) {
      ResetLvlTwo();
    }
  }

  //shows defeat when player box collide with enemy box
  if (defeat) {
    //prevents victory from showing
    currentTimer = millis();
    Defeat();
    if (millis() - resetTimer >= 2000) {
      ResetLvlTwo();
    }
  }
}


class Boxes {
  //class variables
  float x, y, speed, size, angle;
  color aColor;

  //constructor
  Boxes() {
    float i = random(width);
    float j = random(height);

    //makes sure the enemy box does not spawn too close to the center
    //for x coordinate
    if (i >= width/2 - 75 && i <= width/2) {
      i -= random(75, 100);
    } else if (i > width/2 && i <= width/2 + 75) {
      i += random(75, 100);
    }

    //for y coordinate
    if (j >= height/2 - 75 && j <= height/2) {
      j -= random(75, 100);
    } else if (j > height/2 && j <= height/2 + 75) {
      j += random(75, 100);
    }

    //setting variables
    x = i;
    y = j;

    speed = 3;

    angle = radians(random(360));

    aColor = color(35, 120, 0); //dark green
    size = 20;
  }


  //centers the box controlled by the player
  void center() {
    x = width/2;
    y = height/2;
  }

  //changes the box controlled by the player to blue
  void changeToFriendly() {
    aColor = color(2, 90, 215); //light blue
  }

  //displays the box
  void display() {
    rectMode(CENTER);
    fill(aColor);
    rect(x, y, size, size);
  }

  //the boxes will move randomly on screen
  void move() {
    x += cos(angle) * speed;
    y += sin(angle) * speed;
    bounceOnWall();
  }

  //boxes will bounce off the wall if it touches the wall
  void bounceOnWall() {
    if (x < 25 || x > width - 25) {
      angle = PI - angle;
    }
    if (y < 25 || y > height - 25) {
      angle *= -1;
    }
  }
}

//shows all enemy boxes
void displayEnemyBoxes() {
  for (Boxes item : enemyBoxes) {
    item.display();
  }
}

//moves all enemy boxes
void moveEnemyBoxes() {
  for (Boxes item : enemyBoxes) {
    item.move();
  }
}

//moves the player's box when key is pressed
void keyPressed() {
  if (keyCode == LEFT) {
    velX = -3;
  } else if (keyCode == RIGHT) {
    velX = 3;
  } else if (keyCode == UP) {
    velY = -3;
  } else if (keyCode == DOWN) {
    velY = 3;
  }
}

//stops movement when key is not pressed
void keyReleased() {
  if (keyCode == LEFT) {
    velX = 0;
  } else if (keyCode == RIGHT) {
    velX = 0;
  } else if (keyCode == UP) {
    velY = 0;
  } else if (keyCode == DOWN) {
    velY = 0;
  }
}

//moves the box when movement key is pressed
void movePlayerBox() {
  playerBox.x += velX;
  playerBox.y += velY;
  playerBox.x = constrain(playerBox.x, 10, width - 10);
  playerBox.y = constrain(playerBox.y, 10, height - 10);
}

//resets the level when level is complete
void ResetLvlTwo() {
  enemyBoxes.clear();
  playerBox.x = width/2;
  playerBox.y = height/2;
  defeat = false;
}
