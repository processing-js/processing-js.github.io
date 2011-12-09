
boolean play = false;



float frame = 0;			// we start at frame 0

float framerate = 24;		// our "sketch" will have a framerate of 24 frames per second.



int ball_x;				// ball administration: x coordinate

int ball_y;				// ball administration: y coordinate

int ball_radius = 20;		// ball administration: ball radius



void setup() {

  size(200,200); 			// set draw area size

  frameRate(framerate);	// set animation framerate

  ball_x = width/2;		// set the initial ball coordinates

  ball_y = ball_radius;		// set the initial ball coordinates

  stroke(#003300);		// set the default shape outline colour

  fill(#0000FF);			// set the default shape fill colour

}



void draw() {

  frame++;											// note that we're one frame further than last time

  float bounce_height = height/2 * abs(sin(PI*frame/framerate));	// compute the ball height for this frame

  float ball_height = height - (bounce_height+ball_radius);		// because the top of the screen is 0, and the bottom is "height",

  background(#FFFFEE);								// clear the drawing area

  ball_y = (int) (ball_height);								// set the new ball y position

  ellipse(ball_x,ball_y,ball_radius,ball_radius); 				// draw the ball

  if(!play) { stop(); }

}



void playSketch() {

  play = true;

  frameRate(24);

  loop(); }



void stop() {

  noLoop();

  fill(0,0,200,50);

  rect(0,0,width,height);

  stroke(#003300);

  fill(#0000FF);

}