
Bouncer[] bouncer = new Bouncer[3];



void setup() {

  size(200,200);

  frameRate(24);

  stroke(#003300);

  fill(#0000FF);

  bouncer[0] = new Ball(width/3-20,20,20);

  bouncer[1] = new Box(width/2-10,20,20,20);

  bouncer[2] = new Ball((2*width/3)+20,20,20); 

}



void draw() {

  for(int b=0, end=bouncer.length; b<end;b++) {

    bouncer[b].computeNextStep(width, height, frameRate); }

  background(#FFFFEE);

  for(int b=0, end=bouncer.length; b<end;b++) {

    bouncer[b].draw(); }

  if(!play) { stop(); }

}



void mousePressed() {

  for(int b=0, end=bouncer.length; b<end;b++) {

    if(bouncer[b].mouseOver(mouseX, mouseY)) {

      bouncer[b].mousePressed(); }}

}



void mouseReleased() {

  for(int b=0, end=bouncer.length; b<end;b++) {

    bouncer[b].mouseReleased(); }

}



class Bouncer

{

	int x, y;

	boolean canmove = true;

	int step = 0;

	void computeNextStep(int width, int height, float framerate) {}

	void draw() {}

	boolean mouseOver(int mx, int my) {}

	void mousePressed() { canmove = false; }

	void mouseReleased() { canmove = true; }

}



class Ball extends Bouncer

{

  int radius;



  Ball(int x, int y, int r) {

    this.x = x;

    this.y = y;

    this.radius = r;  }



  void computeNextStep(int sketch_width, int sketch_height, float frame_rate) {

    if(canmove) {

      step = (int)((step+1) % frame_rate);

      float sin_value = abs(sin(PI*step/(float)frame_rate));

      float bounce_height = sketch_height/2 * sin_value;

      float ball_height = sketch_height - (bounce_height + radius);

      y = (int) (ball_height); }}



  void draw() { ellipse(x,y,radius,radius); }



  boolean mouseOver(int mx, int my) {

    return sqrt((x-mx)*(x-mx) + (y-my)*(y-my)) <= radius; }

}



class Box extends Bouncer

{

  int w,h;

  int step=0;



  Box(int x, int y, int w, int h) {

    this.x = x;

    this.y = y;

    this.w = w;

    this.h = h; }



  void computeNextStep(int sketch_width, int sketch_height, float frame_rate) {

    if(canmove) {

      step = (int)((step+1) % frame_rate);

      float sin_value = abs(sin(PI/2.0 + (PI*step/(float)frame_rate)));

      float bounce_height = sketch_height/2 * sin_value;

      float ball_height = sketch_height - (bounce_height + h);

      y = (int) (ball_height); }}



  void draw() { rect(x,y-h/2,w,h); }



  boolean mouseOver(int mx, int my) {

    return x<=mx && mx<=x+w && (y-h/2)<=my && my<=(y+h/2); }

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