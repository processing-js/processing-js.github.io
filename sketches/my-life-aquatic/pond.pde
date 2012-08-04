ArrayList<Bubble> foregroundBubbles;
ArrayList<Bubble> backgroundBubbles; 
ArrayList<Food> foods;
Fish myFish;

public void setup() {
    int pondWidth = 575;
    int pondHeight = 480;

	size(pondWidth, pondHeight);

	frameRate(45); //45
	
    PVector location = new PVector(random(0.2 * pondWidth, 0.8 * pondWidth), 
        random(0.2 * pondHeight, 0.8 * pondHeight));
    myFish = new Fish(location, random( 2.0, 2.5 ), 0.2);

    foregroundBubbles = new ArrayList<Bubble>();
    backgroundBubbles = new ArrayList<Bubble>();

    foods = new ArrayList<Food>();
}


public void draw() {
	background( 105, 210, 231, 0);

    randomNumber = random(0, 1000);

    if(randomNumber > 980) {
        foregroundBubbles.add(new Bubble( color(int(random(100, 255)), 200)));
    } 
    else if(randomNumber < 20) {
        backgroundBubbles.add(new Bubble( color(int(random(100, 255)), 100)));
    }

    for(int i = backgroundBubbles.size()-1; i >= 0; i--) {
        Bubble bubble = backgroundBubbles.get(i);
        if (bubble.getLocation().y < -50)
            backgroundBubbles.remove(i);
        else {
            bubble.update();
            bubble.render();
        }
    }
     
    myFish.update();
    myFish.render();
    if(myFish.getFoodEaten() > 11 && !myFish.getIsExploding()) {
        myFish.explode();
    }

    for(int i = foregroundBubbles.size()-1; i >= 0; i--) {
        Bubble bubble = foregroundBubbles.get(i);
        if (bubble.getLocation().y < -50)
            foregroundBubbles.remove(i);
        else {
            bubble.update();
            bubble.render();
        }
    }

    if(randomNumber <= 6) {
        PVector foodLocation = new PVector(random(100, width-100), random(100,height-100));
        Food food = new Food(foodLocation);
        foods.add(food);
    }

    for(int i = foods.size()-1; i >= 0; i--) {
        Food food = foods.get(i);
        boolean foodEaten = false;
        if (!food.getIsDead()) {
            food.update();
            food.render();
            foodEaten = myFishAteFood(food);
        }
        else
            foods.remove(i);
        if (foodEaten)
            foods.remove(i);
    }
}

public boolean myFishAteFood(Food food) {
    boolean foodEaten = false;

    float distanceToFood = PVector.sub(myFish.getLocation(), food.getLocation()).mag();
    if (distanceToFood < 10){
        foodEaten = true;
        gulp.play();
        myFish.setBodySizeH(myFish.getBodySizeH() * 1.1);
        myFish.setBodySizeW(myFish.getBodySizeW() * 1.1);
        myFish.setLastAteTimer(int(frameRate/2));
        myFish.setFoodEaten(myFish.getFoodEaten() + 1);
    }

    return foodEaten;
}

public void mouseMoved() {
    PVector mousePosition = new PVector(mouseX, mouseY);
    myFish.setMousePosition(mousePosition);
}