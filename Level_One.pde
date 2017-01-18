//keeps track of all images
PImage [] levelOneImages = new PImage[13];

//loads certain image
int levelOneImageNumber = 1;

//keeps the x coordinate of the sprite
float levelOneSpriteX = 50;


void LevelOne() {
  //continues to draw until the level is complete
    if (!levelComplete) {

    //resets the background
    image(levelOneImages[0], 0, 0);

    //draws the sprite
    pushMatrix();
    translate(levelOneSpriteX, height/2 + 50);
    image(levelOneImages[levelOneImageNumber], 0, 0);
    popMatrix();

    //gives instruction to the player
    textAlign(CENTER);
    fill(5, 70, 255);
    text("Get to the other side!", width/2, height/2 - 75);

    //draw timer
    Timer();

    // setting up controls
    if (keyPressed) {
      //runs right when right arrow is pressed
      if (keyCode == RIGHT) {
        levelOneSpriteX += 2.4;
        if (levelOneImageNumber < 12) {
          levelOneImageNumber++;
        } else {
          levelOneImageNumber = 1;
        }
      }
      //runs left when left arrow is pressed
      else if (keyCode == LEFT) {
        levelOneSpriteX -= 2.4;
        if (levelOneImageNumber < 12) {
          levelOneImageNumber++;
        } else {
          levelOneImageNumber = 1;
        }
      }
    }

    //keeps the reset timer
    resetTimer = millis();
  }

  //shows victory when sprite gets to the end
  if (levelOneSpriteX >= width - 50) {
    //prevents defeat from occuring
    currentTimer = millis();
    Victory();
    if (millis() - resetTimer >= 2000) {
      ResetLvlOne();
    }
  
  }
  
  //shows defeat if player doesn't get to the end by 5 seconds
  else if (millis() - currentTimer >= 5000) {
    Defeat();
    if (millis() - resetTimer >= 2000) {
      ResetLvlOne();
    }
    
  }
}

//resets the sprite to the beginning
void ResetLvlOne(){
  levelOneImageNumber = 1;
  levelOneSpriteX = 50;
}

