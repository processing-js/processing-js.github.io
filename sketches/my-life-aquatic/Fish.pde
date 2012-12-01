class Fish extends Boid {
	
	private Flagellum body;
	private Flagellum tailR;
	private Flagellum tailL;
	private Flagellum finR;
	private Flagellum finL;
	
	// After eating, this gets set to frameRate/2. It is decremented
	// each loop by one until it hits zero. While it is non-zero, we display
	// the fish's mouth
	private int lastAteTimer;
	private int numBodySegments;
	private int numTailSegments;
	private int numFinSegments;
	private int foodEaten;
	private int transparency;
	private int explosionTimer;
	
	private float bodySizeW;
	private float bodySizeH;
	private float tailSizeW;
	private float tailSizeH;

    private Color mainColor;
    private Color stripeColor;
    private Color outlineColor;

    private PVector mousePosition;
    private PVector mousePositionOld;

    private boolean isExploding;
	
	// Constructor to create your personal, local fish
	public Fish(PVector location, float maxSpeed, float maxForce) {
        stripeColor = color(int(random(255)), int(random(255)), int(random(255)));
		bodySizeW		= random( 100, 200 );
		bodySizeH		= (bodySizeW * 0.3 + random( 5 ));
        mousePosition = new PVector(0, 0);
        lastAteTimer = 0;
        isExploding = false;
        foodEaten = 0;
        transparency = 255;

        createFish(location, maxSpeed, maxForce);
    }

    private void createFish(PVector location, float maxSpeed, float maxForce) {
    	mousePositionOld = new PVector(mousePosition.x, mousePosition.y);
		super(location, maxSpeed, maxForce);
        mainColor = #000000;
        outlineColor = #D8D8C0;
		
		numBodySegments = 10;
		
		numTailSegments = 10;
		tailSizeW		= bodySizeW * 0.6;
		tailSizeH		= bodySizeH * 0.25;
		
		body = new Flagellum( bodySizeW, bodySizeH, numBodySegments );
		
		tailR = new Flagellum( tailSizeW, tailSizeH, numTailSegments );
		tailL = new Flagellum( tailSizeW * 0.8, tailSizeH * 0.8, numTailSegments );
		
		numFinSegments = 9;
		finR = new Flagellum( tailSizeW * 0.5, tailSizeH, numFinSegments );
		finL = new Flagellum( tailSizeW * 0.5, tailSizeH, numFinSegments );
	}
	
	public void update() {
		super.update();

		checkBorders();
		// super.wander();
		
		body.muscleFreq = norm(super.velocity.mag(), 0, 1) * 0.05;
		
		// Align body to velocity
		body.theta 	= super.velocity.heading2D();
		body.swim();
		
		float diffX 		= body.spine[numBodySegments-1][0] - body.spine[numBodySegments-2][0];
		float diffY 		= body.spine[numBodySegments-1][1] - body.spine[numBodySegments-2][1];
		float angle			= atan2( diffY, diffX );
		
		tailR.muscleFreq 	= norm( super.velocity.mag(), 0, 1 ) * 0.08;
		tailR.theta 		= angle + (PI * 0.95);
		tailR.swim();
		
		tailL.muscleFreq 	= norm( super.velocity.mag(), 0, 1 ) * 0.08;
		tailL.theta 		= angle + (PI * 1.05);
		tailL.swim();
		
		finR.muscleFreq 	= norm( super.velocity.mag(), 0, 1 ) * 0.04;
		finR.swim();
		
		finL.muscleFreq 	= norm( super.velocity.mag(), 0, 1 ) * 0.04;
		finL.swim();

		// only change fish velocity if the mouse moved. this makes the fish keep moving as opposed 
		// to "seizuring up" when they reach the mouse
		if(mousePosition.x != mousePositionOld.x ||
			mousePosition.y != mousePositionOld.y)
        	seek(mousePosition);
        mousePositionOld = mousePosition;

        // logic to explode if fish ate too much (called from explode method)
        if(isExploding) {
        	bodySizeW = bodySizeW * 1.3;
        	bodySizeH = bodySizeH * 1.3;

        	transparency = (explosionTimer / frameRate) * 255;

        	explosionTimer--;
        }
	}
	
	public void render() {
		noStroke();

		// render fins
		PVector finLLocation = new PVector( super.location.x + body.spine[3][0], super.location.y + body.spine[3][1] );
		PVector finRLocation = new PVector( super.location.x + body.spine[3][0], super.location.y + body.spine[3][1] );
		
		fill(mainColor, transparency);
		renderFin(finR, finLLocation,  bodySizeH * 0.5, 1);
		fill(mainColor, transparency);		
		renderFin(finL, finRLocation, -bodySizeH * 0.5, -1);
		
		// render body
		fill(outlineColor, transparency);
		renderBody( body, super.location, 1.1, 0.1 );
		fill(stripeColor, transparency);
		renderBody( body, super.location, 0.8, 0.15 );
		fill(mainColor, transparency);
		renderBody( body, super.location, 0.5, 0.25 );
		
		// render tails
		PVector tailLocation = new PVector( super.location.x + body.spine[numBodySegments - 1][0], super.location.y + body.spine[numBodySegments - 1][1] );
		fill(mainColor, transparency);
		renderTail( tailR, tailLocation, 0.75 );
		fill(mainColor, transparency);
		renderTail( tailL, tailLocation, 0.75 );
		
		// render head
		PVector headLocation = new PVector( super.location.x + body.spine[1][0], super.location.y + body.spine[1][1] );
		renderHead( headLocation, bodySizeW * 0.1, bodySizeW * 0.06 );

		// render mouth if fish ate recently
		fill(250, 128, 114, transparency);
		if(lastAteTimer > 0) {
			lastAteTimer--;
			float mouthSize = (bodySizeW*.05) * (float) lastAteTimer / (frameRate/2)
			ellipse(location.x,location.y,mouthSize,mouthSize);
		}
	}
	
	private void renderHead( PVector _location, float _eyeSize, float _eyeDist ) {
		float diffX = body.spine[2][0] - body.spine[1][0];
		float diffY = body.spine[2][1] - body.spine[1][1];
		float angle	= atan2( diffY, diffX );
		
		pushMatrix();
		translate( _location.x, _location.y );
		rotate( angle );
		
		fill(mainColor, transparency);
		ellipse( 0, _eyeDist, _eyeSize, _eyeSize );
		
		fill(stripeColor, transparency);
		ellipse( -3, _eyeDist, _eyeSize * 0.35, _eyeSize * 0.35 );
		
		popMatrix();
		
		pushMatrix();
		translate( _location.x, _location.y );
		rotate( angle );
		
		fill(mainColor, transparency);
		ellipse( 0, -_eyeDist, _eyeSize, _eyeSize );
		
		fill(stripeColor, transparency);
		ellipse( -3, -_eyeDist, _eyeSize * 0.35, _eyeSize * 0.35 );
		
		popMatrix();
	}
	
	private void renderBody( Flagellum _flag, PVector _location, float _sizeOffsetA, float _sizeOffsetB ) {
		pushMatrix();
		translate( _location.x, _location.y );
		beginShape( TRIANGLE_STRIP );
		for ( int n = 0; n < _flag.numNodes; n++ ) {
			float dx, dy;
			if ( n == 0 ) {
				dx = _flag.spine[1][0] - _flag.spine[0][0];
				dy = _flag.spine[1][1] - _flag.spine[0][1];
			}
			else {
				dx = _flag.spine[n][0] - _flag.spine[n - 1][0];
				dy = _flag.spine[n][1] - _flag.spine[n - 1][1];
			}
			
			float theta = -atan2( dy, dx );
			
			float t 	= n / float(_flag.numNodes - 1);
			float b		= bezierPoint( 3, bodySizeH * _sizeOffsetA, bodySizeH * _sizeOffsetB, 2, t );
			
			float x1	= _flag.spine[n][0] - sin( theta ) * b;
			float y1 	= _flag.spine[n][1] - cos( theta ) * b;
			
			float x2 	= _flag.spine[n][0] + sin( theta ) * b;
			float y2 	= _flag.spine[n][1] + cos( theta ) * b;
			
			vertex( x1, y1 );
			vertex( x2, y2 );
		}

		endShape();
		popMatrix();
	}
	
	
	private void renderTail( Flagellum _flag, PVector _location, float _sizeOffset ) {
		pushMatrix();
		translate( _location.x, _location.y );
		
		beginShape( TRIANGLE_STRIP );
		for ( int n = 0; n < _flag.numNodes; n++ ) {
			float dx, dy;
			if ( n == 0 ) {
				dx = _flag.spine[1][0] - _flag.spine[0][0];
				dy = _flag.spine[1][1] - _flag.spine[0][1];
			}
			else {
				dx = _flag.spine[n][0] - _flag.spine[n - 1][0];
				dy = _flag.spine[n][1] - _flag.spine[n - 1][1];
			}
			
			float theta = -atan2( dy, dx );
			
			float t 	= n / float(_flag.numNodes - 1);
			float b		= bezierPoint( 2, _flag.sizeH, _flag.sizeH * _sizeOffset, 0, t );
			
			float x1	= _flag.spine[n][0] - sin( theta ) * b;
			float y1 	= _flag.spine[n][1] - cos( theta ) * b;
			
			float x2 	= _flag.spine[n][0] + sin( theta ) * b;
			float y2 	= _flag.spine[n][1] + cos( theta ) * b;
			
			vertex( x1, y1 );
			vertex( x2, y2 );
		}
		endShape();
		
		popMatrix();
	}
	
	
	private void renderFin( Flagellum _flag, PVector _location, float _posOffset, int _flip ) {
		float diffX = body.spine[2][0] - body.spine[1][0];
		float diffY = body.spine[2][1] - body.spine[1][1];
		float angle	= atan2( diffY, diffX );
		
		pushMatrix();
		translate( _location.x, _location.y );
		rotate( angle );
		
		pushMatrix();
		translate( 0, _posOffset );
		
		beginShape(TRIANGLE_STRIP);
		for ( int n = 0; n < _flag.numNodes; n++ ) {
			float dx, dy;
			if ( n == 0 ) {
				dx = _flag.spine[1][0] - _flag.spine[0][0];
				dy = _flag.spine[1][1] - _flag.spine[0][1];
			}
			else {
				dx = _flag.spine[n][0] - _flag.spine[n - 1][0];
				dy = _flag.spine[n][1] - _flag.spine[n - 1][1];
			}
			
			float theta = -atan2( dy, dx );
			
			float t 	= n / float(_flag.numNodes - 1);
			float b		= bezierPoint( 0, _flip * _flag.sizeH * 0.75, _flip * _flag.sizeH * 0.75, 0, t );
			float v		= bezierPoint( 0, _flip * _flag.sizeH * 0.05, _flip * _flag.sizeH * 0.65, 0, t );
			
			float x1	= _flag.spine[n][0] - sin( theta ) * v;
			float y1 	= _flag.spine[n][1] - cos( theta ) * v;
			
			float x2 	= _flag.spine[n][0] + sin( theta ) * b;
			float y2 	= _flag.spine[n][1] + cos( theta ) * b;
			
			vertex( x1, y1 );
			vertex( x2, y2 );
		}

		endShape();
		popMatrix();
		popMatrix();
	}

	/**
	 *	ensure that the fish wraps around the the other end of the pond
	 *	if it goes past the edge. Also keeps unModdedLocations in sync with
	 *	location
	 */
	private void checkBorders() {
		if ( location.x < -bodySizeW ) {
			location.x = width;
		}
		if ( location.x > width + bodySizeW ) {
			location.x = 0;
		}
		if ( location.y < -bodySizeW ) {
			location.y = height;
		}
		if ( location.y > height + bodySizeW ) {
			location.y = 0;
		}
	}	

	public void explode() {
		explosion.play(); // play explosion sound with buzz
		//prevent the mouth from rendering during explosion
		lastAteTimer = 0;
		isExploding = true;
		explosionTimer = frameRate;
	}

    // Getters
    public Color getStripeColor() {
        return stripeColor;
    }

    public float getBodySizeW() {
        return bodySizeW;
    }

    public float getBodySizeH() {
        return bodySizeH;
    }
    
    public PVector getMousePosition() {
        return mousePosition;
    }

    public void setMousePosition(PVector position) {
        mousePosition = position;
    }

    public float getBodySizeH(){
    	return bodySizeH;
    }

    public void setBodySizeH(float bodySizeH){
    	this.bodySizeH = bodySizeH;
    }

    public float getBodySizeW(){
    	return bodySizeW;
    }

    public void setBodySizeW(float bodySizeW){
    	this.bodySizeW = bodySizeW;
    }

    public int getLastAteTimer() {
    	return lastAteTimer;
    }

    public void setLastAteTimer(int lastAteTimer) {
    	this.lastAteTimer = lastAteTimer;
    }

    public boolean getIsExploding(){
    	return isExploding;
    }

    public int getFoodEaten(){
    	return foodEaten;
    }

    public void setFoodEaten(int foodEaten){
    	this.foodEaten = foodEaten;
    }

    public int getTransparency() {
    	return transparency;
    }

    public void setTransparency(int transparency) {
    	this.transparency = transparency;
    }

    public int getExplosionTimer() {
    	return explosionTimer;
    }
}