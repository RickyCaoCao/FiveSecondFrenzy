//Richard Cao
//Comp. Sci. 30, Mr. Schellenberg
//"Five Second Frenzy"
//Progress: -Made Victory/Defeat Screen For Level
//-Made it Reset Every Time a level is Beat
//-Made one level
//Essentially, I created the basic setup, so that anyone can just make a game within the given settings.

//Notes: -Could be a good game to make in the Pair Programming Assignment
//-Polish levels (for even better appeal)
//-Unpacker needs to work so I can actually put Megaman sprites instead of Mario >_<
//-Victory and Defeat may simutaneously come on, will fix this

//this boolean allows the title screen to work
boolean gameBegin = false;

//randomly selects a level
int stage = 0;
//broadcast when level is over
boolean levelComplete = false;

//for in game text
PFont gameFont;
String victoryWord;

//vars used to draw the five second bar
long currentTimer;
float pBar_width;

//var used to reset level
long resetTimer;


//Creating timer
void setup() {
  //setting up screen
  size(600, 600);
  background(255);

  //setting up game font
  gameFont = createFont("CooperBlackStd.vlw", 48);
  textFont(gameFont);

  //loads sprite images
  for (int i = 1; i <= 12; i++) {
    levelOneImages[i] = loadImage("levelOne_" + i + ".png");
  }

  //loads background
  levelOneImages[0] = loadImage("levelOne_0.jpg");
  levelOneImages[0].resize(600, 600);
}

void draw() {
  //will stop once game begins
  if (!gameBegin) {
    //allows the game to load without starting
    if(millis() < 2000){
      currentTimer = millis();
    }
    else if(millis() > 2000){
      TitleScreen();
    } 
  }

  //waits until title screen is completed
  if (gameBegin) {
    StartLevel();
  }
}

void TitleScreen() {
  //refreshes background
  background(255);

  //sets up text color and alignment
  fill(0);
  textAlign(CENTER, CENTER);

  //displays text based on time, eventually starting game
  if (millis() - currentTimer <= 1500) {
    text("READY?", width/2, height/2);
  } else if (millis() - currentTimer <= 2500) {
    text("SET.", width/2, height/2);
  } else if (millis()-currentTimer <= 3500) {
    text("GO!", width/2, height/2);
  } else {
    gameBegin = true;

    //begins the first reset, defining certain variables
    Reset();
  }
}

void Timer() {
  //draws a grey bar
  rectMode(CORNER);
  stroke(1);  
  fill(175);
  rect(50, height - 100, width - 100, 50);
  
  //decreases width as time increases
  pBar_width = (5000.0 - (millis()- currentTimer)) / 5000.0 * 500.0;
  pBar_width = constrain(pBar_width, 2, 500);
  
  if (millis() - currentTimer <= 1500) {
    fill(25, 255, 25); //color is green for 1.5s 
  } else if (millis() - currentTimer <= 3000) {
    fill(255, 255, 10); //color changes to yellow for 1s
  } else if (millis() - currentTimer <= 4000) {
    fill(255, 140, 10); //color changes to orange for 1s
  } else if (millis() - currentTimer <= 5000) {
    fill(255, 10, 10); //color chances to red for 1s
  }
  
  //draws the dynamic timer
  rectMode(CORNERS);
  rect(51, height - 99, pBar_width + 48, height-51);
}

void Reset() {
  //resets timer
  currentTimer = millis();

  //resets victory word
  int randomChance = int(random(3));
  if (randomChance == 0) {
    victoryWord = "NICE!";
  } else if (randomChance == 1) {
    victoryWord = "CONGRATS!";
  } else {
    victoryWord = "AWESOME!";
  }

  //resets next level
  stage = int(random(1, 3));
  levelComplete = false;
}

void Victory() {
  //broadcasts that level has finished
  levelComplete = true;
  
  //creates a small grey rectangle in center of screen
  fill(175, 175, 175, 50);
  rectMode(CORNER);
  stroke(1);
  rect(0, height/2 - 50, width, 100);

  //display a victorious word in blue
  fill(2, 120, 210);
  textAlign(CENTER, CENTER);
  text(victoryWord, width/2, height/2);
  
  //sends back to titlescreen after 2 seconds
  if (millis() - resetTimer >= 2000){
    stage = 0;
    currentTimer = millis();
  }
}

void Defeat() {
  //broadcasts that level has finished
  levelComplete = true;
  
  fill(175, 175, 175, 50);
  rectMode(CORNER);
  stroke(1);
  rect(0, height/2 - 50, width, 100);

  //displays defeat in red
  fill(255, 25, 5);
  textAlign(CENTER, CENTER);
  text("NOOOOOOO!", width/2, height/2);
  
  //sends back to titlescreen after 2 seconds
  if (millis() - resetTimer >= 2000){
    stage = 0;
    currentTimer = millis();
  }
}

void StartLevel() {
  //keeps track of all the levels and title screen
  if (stage == 0) {
    TitleScreen();
  }
  if (stage == 1) {
    LevelOne();
  } else if (stage == 2) {
    LevelTwo();
  }
}

