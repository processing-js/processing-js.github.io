
ArrayList points;



ArrayList getPoints() { return points; }



void setup() {

  size(200,200);

  points = new ArrayList(); 

  noLoop();

  stroke(255,0,0);

  fill(255); }



void draw() {

  background(200,200,255);

  for(int p=0, end=points.size(); p<end; p++) {

    Point pt = (Point) points.get(p);

    if(p<end-1) {

      Point next = (Point) points.get(p+1);

      line(pt.x,pt.y,next.x,next.y); }

    pt.draw(); }}



void mouseClicked() {

  points.add(new Point(mouseX,mouseY));

  redraw(); }



class Point {

  int x,y;

  Point(int x, int y) { this.x=x; this.y=y; }

  void draw() { ellipse(x,y,10,10); }}