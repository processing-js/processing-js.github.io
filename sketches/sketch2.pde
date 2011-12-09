
Bouncer bouncer;



void setup() {

  size(200,200);

  frameRate(24);

  stroke(#003300);

  fill(#0000FF);

  bouncer = new Ball(width/2,20,20);

}



void draw() {

  bouncer.computeNextStep(width, height, frameRate);

  background(#FFFFEE);

  bouncer.draw();

  if(!play) { stop(); }

}



interface Bouncer {

	void computeNextStep(int width, int height, float framerate);

	void draw(); }



class Ball implements Bouncer

{

  int x,y,radius;

  int step=0;



  Ball(int x, int y, int r) {

    this.x = x;

    this.y = y;

    this.radius = r;  }



  void computeNextStep(int sketch_width, int sketch_height, float frame_rate) {

    step++;

    float sin_value = abs(sin(PI*step/(float)frame_rate));

    float bounce_height = sketch_height/2 * sin_value;

    float ball_height = sketch_height - (bounce_height + radius);

    y = (int) (ball_height); }



  void draw() { ellipse(x,y,radius,radius); }

}



boolean play = false;



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