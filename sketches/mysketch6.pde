
ArrayList points;



void setup() {

  size(200,200);

  points = new ArrayList(); }



void draw() {

  background(200,200,255);

  for(int p=0, end=points.size(); p<end; p++) {

    Point pt = (Point) points.get(p);

    if(p<end-1) {

      Point next = (Point) points.get(p+1);

      line(pt.x,pt.y,next.x,next.y); }

    pt.draw(); }}



void mouseClicked() {

  addPoint(mouseX,mouseY); }



Point addPoint(int x, int y) {

  Point pt = new Point(x,y);

  points.add(pt);

  return pt; }



class Point {

  int x,y;

  Point(int x, int y) { this.x=x; this.y=y; }

  void draw() {

    stroke(255,0,0);

    fill(255);

    ellipse(x,y,10,10); }}