// 	(C) JOAO MARTINHO MOURA, 2011
//
//		www.jmartinho.net
//
//		
//		HTML5 Visual Art - 'Transversal Lines', 2011
//		
//		Transversal Lines: infinite abstract visual b&w line work,
//		by Joao Martinho Moura, 2011. 
//		
//		Made in processing & processingJS
//		
//
//		
//		
//		http://jmartinho.net/digitalArt-html5/index.php?art=tr-lines
//	




int contadorTempoRefresh = 0;

int tempoBrancoPreto = 0;
int tempoApaga = 0;
int tempo = 0;

int tamanhoWIDTH = 575;
int tamanhoHEIGHT = 480;

int numeroPontos = 30;

int[] NumerosArrayX = new int[numeroPontos];
int[] NumerosArrayY = new int[numeroPontos];


int[] RND_NumerosArrayX = new int[numeroPontos];
int[] RND_NumerosArrayY = new int[numeroPontos];


int contaMouse=0;
int MX = tamanhoWIDTH/2;
int MY = tamanhoHEIGHT/2;

void setup() {
  
  frameRate(25);
  smooth();
  background(255,255,255);
  size(tamanhoWIDTH, tamanhoHEIGHT);

  for (int i = 0; i < numeroPontos; i++) {
    NumerosArrayX[i] = tamanhoWIDTH/2;
    NumerosArrayY[i] = tamanhoHEIGHT/2;
  }

  for (int i = 0; i < numeroPontos; i++) {
    RND_NumerosArrayX[i] = tamanhoWIDTH/2;
    RND_NumerosArrayY[i] = tamanhoHEIGHT/2;
  }
  
}

void draw() {

  tempoApaga ++;

  if (tempoApaga>100) {
    fill(255,255,255,10);
    noStroke();
    rect(-20,-20,tamanhoWIDTH+20,tamanhoHEIGHT+20);
    tempoApaga=0;
  }

  tempo++;
  if (mousePressed == true) {
    MX = mouseX;
    MY = mouseY;
  }
  else {
    if (tempo>15) {
      MX = int(random (50,tamanhoWIDTH-50));
      MY = int(random (100,tamanhoHEIGHT-100));
      tempo=0;
    }
  }

  contaMouse ++;

  if (contaMouse < numeroPontos) {

    if  ( (MX > 40) && (MX < tamanhoWIDTH-40) ) {
      NumerosArrayX[contaMouse] = MX;
      RND_NumerosArrayX[contaMouse] = MX + int(random(-10,10));
    }

    if  ( (MY > 40) && (MY < tamanhoHEIGHT-40) ) {
      NumerosArrayY[contaMouse] = MY;
      RND_NumerosArrayY[contaMouse] = MY + int(random(-10,10));
    }
  }
  else {
    contaMouse=0;
  }

  tempoBrancoPreto++;
  if (tempoBrancoPreto>400) {
    tempoBrancoPreto=0;
  }

  if (tempoApaga==50) {
    strokeWeight(10);
  }
  else {
    strokeWeight(1);
  }


  if (tempoApaga==400) {
    strokeWeight(10);
  }
  else {
    strokeWeight(1);
  }

  for (int i = 0; i < numeroPontos; i ++) {
    if ((i>0) && (i < numeroPontos)) {
      stroke(10,10,10,20);
      line(RND_NumerosArrayX[i],RND_NumerosArrayY[i],RND_NumerosArrayX[i-1],RND_NumerosArrayY[i-1]);
      if (tempoBrancoPreto<200) {
        stroke(5,5,5,80);
      }
      else {
        stroke(255,255,255,90);
      }

      line(NumerosArrayX[i],NumerosArrayY[i],NumerosArrayX[i-1],NumerosArrayY[i-1]);
    }

    NumerosArrayX[i] = NumerosArrayX[i] + int(random(-3,3));
    NumerosArrayY[i] = NumerosArrayY[i] + int(random(-3,3));


    RND_NumerosArrayX[i] = RND_NumerosArrayX[i] + int(random(-5,5));
    RND_NumerosArrayY[i] = RND_NumerosArrayY[i] + int(random(-5,5));
    
    
    if (NumerosArrayX[i]<0 || NumerosArrayX[i]>width) NumerosArrayX[i] = random(0,width);
    if (NumerosArrayY[i]<0 || NumerosArrayY[i]>height) NumerosArrayY[i] = random(0,height);
    
    if (RND_NumerosArrayX[i]<0 || RND_NumerosArrayX[i]>width) RND_NumerosArrayX[i] = random(0,width);
    if (RND_NumerosArrayY[i]<0 || RND_NumerosArrayY[i]>height) RND_NumerosArrayY[i] = random(0,height);
    
    
  }

  contadorTempoRefresh++;
  if (contadorTempoRefresh>1600) {
    background(255);
    contadorTempoRefresh=0;
  }
  
}



