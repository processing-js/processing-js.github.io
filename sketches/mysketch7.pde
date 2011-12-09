
ArrayList points;



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

      line(pt.x,pt.y, next.x,next.y); }

    pt.draw(); }}



void mouseClicked() {

  points.add(new Point(mouseX,mouseY));

  redraw(); }



void buildFromXML(String xml) {

  XMLElement data = new XMLElement(xml);

  XMLElement[] xmlpoints = data.getChildren();

  for(int p=0, end=xmlpoints.length; p<end; p++)

  {

    XMLElement xmlpoint = xmlpoints[p];

    int x = xmlpoint.getIntAttribute("x");

    int y = xmlpoint.getIntAttribute("y");   

    points.add(new Point(x, y));

  }

  redraw(); }



class Point {

  int x,y;

  Point(int x, int y) { this.x=x; this.y=y; }

  void draw() { ellipse(x,y,10,10); }}