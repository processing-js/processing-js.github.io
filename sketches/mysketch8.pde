
XMLElement svgxml;

PShape ps;

int x=0;

int y=0;

int xoffset=0;

int yoffset=0;

int xmark=0;

int ymark=0;



void setup() {

  size(200,200);

  noLoop(); 

  buildFromSVG("<svg width='200' height='200'><path d='M 10 10 L 190 10 L 140 100 L 190 190 L 10 190 L 50 100 L 10 10 M 100 80 L 140 30 L 50 30 L 100 80 M 100 120 L 50 170 L 140 170 Z'/></svg>");

}



void draw() {

  background(255);

  stroke(0);

  for(int px=0; px<width; px+=10) { line(px,0,0,px); }

  for(int py=0; py<height; py+=10) { line(width,py,0,py+height); }

  stroke(#000066);

  for(int py=0; py<height;py+=10) { line(0,py,width,py); }

  if(ps!=null) { shape(ps,x-xoffset,y-yoffset,200,200); }}



void mousePressed() {

  xmark = mouseX;

  ymark = mouseY; }



void mouseDragged() {

  xoffset = xmark-mouseX;

  yoffset = ymark-mouseY; 

  redraw(); }



void mouseReleased() {

  if(xoffset!=0 || yoffset!=0) {

    x -= xoffset;

    y -= yoffset;

    xoffset=0;

    yoffset=0; }

  else {

    XMLElement path = svgxml.getChild(0);

    path.setAttribute("fill",getNextColor());

    bindSVG(svgxml); }}



String[] colors = {"#f0f8ff","#faebd7","#00ffff","#7fffd4","#f0ffff","#f5f5dc","#ffe4c4","#000000","#ffebcd","#0000ff","#8a2be2","#a52a2a","#deb887","#5f9ea0","#7fff00","#d2691e","#ff7f50","#6495ed","#fff8dc","#dc143c","#00ffff","#00008b","#008b8b","#b8860b","#a9a9a9","#006400","#bdb76b","#8b008b","#556b2f","#ff8c00","#9932cc","#8b0000","#e9967a","#8fbc8f","#483d8b","#2f4f4f","#00ced1","#9400d3","#ff1493","#00bfff","#696969","#1e90ff","#b22222","#fffaf0","#228b22","#ff00ff","#dcdcdc","#f8f8ff","#ffd700","#daa520","#808080","#008000","#adff2f","#f0fff0","#ff69b4","#cd5c5c","#4b0082","#fffff0","#f0e68c","#e6e6fa","#fff0f5","#7cfc00","#fffacd","#add8e6","#f08080","#e0ffff","#fafad2","#d3d3d3","#90ee90","#ffb6c1","#ffa07a","#20b2aa","#87cefa","#778899","#b0c4de","#ffffe0","#00ff00","#32cd32","#faf0e6","#ff00ff","#800000","#66cdaa","#0000cd","#ba55d3","#9370d8","#3cb371","#7b68ee","#00fa9a","#48d1cc","#c71585","#191970","#f5fffa","#ffe4e1","#ffe4b5","#ffdead","#000080","#fdf5e6","#808000","#6b8e23","#ffa500","#ff4500","#da70d6","#eee8aa","#98fb98","#afeeee","#d87093","#ffefd5","#ffdab9","#cd853f","#ffc0cb","#dda0dd","#b0e0e6","#800080","#ff0000","#bc8f8f","#4169e1","#8b4513","#fa8072","#f4a460","#2e8b57","#fff5ee","#a0522d","#c0c0c0","#87ceeb","#6a5acd","#708090","#fffafa","#00ff7f","#4682b4","#d2b48c","#008080","#d8bfd8","#ff6347","#40e0d0","#ee82ee","#f5deb3","#ffffff","#f5f5f5","#ffff00","#9acd32"};

int color_len = colors.length; 

int current_color = 0;



String getNextColor() {

  current_color = (current_color+1)%color_len;

  return colors[current_color]; }



void buildFromSVG(String svg) {

  svgxml = new XMLElement(svg);

  bindSVG(svgxml); }



void bindSVG(XMLElement svg) {

  ps = new PShapeSVG(svgxml);

  redraw(); }