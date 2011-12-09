
void setup() {

  size(200,200);

  noLoop();

  stroke(#FFEE88);

  fill(#FFEE88);

  background(#000033);

  text("",0,0);

  textSize(24);

}



void draw() { }



void drawText(String t)

{

  background(#000033);

  float twidth = textWidth(t);

  text(t, (width-twidth)/2, height/2);

}