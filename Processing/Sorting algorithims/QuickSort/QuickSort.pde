/*
* This is a template for creating, testing and visuializing different sorting algorithms
* The elements to be sorted are in the "items" array, these items will be shuffled at the beginning if the program
* The actual code that handles the sorting is held in the "sort" method which is run ussing a processing thread
*
* In this template there is an example of using it for selection sort the code is not necissary for other sorting algorithms and can be deleted
* Made by Garrett Burroughs 3/1/17
*/


//-----GLOBAL VARIABLES----//
int[] items; //The array in which all of the elements to be sorted are stored
int scl; //A dynamic variable that determines the vertical width of the elements in the visualization
boolean sorted = false; //Keeps tack of weather or not the list is sorted
int delay; //delay in ms for each item to be sorted
int fps = 60; //A variable to set the frames per second and set the delay for the sorting so that an element is swapped(sorted) every frame.
int size = 600; // this variable controls the number of elements to be sorted

//Code to be run one time at the begging of the sketch
void setup(){
  size(1200, 800);
  items = new int[size];
  scl = width / items.length;
  for(int i = 1; i < items.length; i++){
    items[i] = items.length - i;
  }
  shuffle(items);
  delay = 1000/fps;
  frameRate(fps);
  thread("sort"); //starting the sorting algorithm

}


//Animation loop: code to be run repeatedly for animation
void draw(){
  background(0);
  if(width/2 <= size){
    noStroke();
  }
  if(isSorted(items)){
    fill(0, 255, 0);
  }else{
    fill(255);
  }
  for(int i = 1; i < items.length; i++){
    float itemHeight = map(items[i], 1, items.length, 1, height); //scales the height to the top of the screen
    rect((i) * scl, height - itemHeight, scl, itemHeight); // draws all of the elements
  }
}


void sort(){
  boolean sorted = false;

  //Variables needed for the sorting algorithm


  while(!sorted){
    //Sorting Code Goes Here
    quicksort(items, 1, items.length-1);

    sorted = isSorted(items);
    delay(delay);
  }
}

//Extra methods commonly used in sorting algorithms


//waits a certain number of milliseconds
void delay(int delay){
  int mill = millis();
  while(millis() < mill + delay){};
}


//swaps elements a and b of an integer array
void swap(int[] array, int a, int b){
  int temp = array[a];
  array[a] = array[b];
  array[b] = temp;
}


//retruns true if the array is sorted
boolean isSorted(int[] array){
  for(int i = 0; i < items.length - 1; i++){
    if(items[i] > items[i + 1]){
      return false;
    }
  }
  return true;
}


//Randomly shuffles all elements of an array
void shuffle(int[] array){
  for(int i = 0; i < array.length; i++){
    swap(array, i, floor(random(array.length - 1)));
  }
}

//quicksort Methods
void quicksort(int[] array, int lo, int hi){
  if(lo < hi){
    int p = partition(array, lo, hi);
    quicksort(array, lo, p);
    quicksort(array, p + 1, hi);
  }
}

int partition(int[] array, int lo, int hi){
  int pivot = array[lo];
  int i = lo - 1;
  int j = hi;
  while (true){
    while (array[i] < pivot){
      i++;
    }
    while (array[j] > pivot){
      j--;
    }
    if (i >= j){
      return j;
    }
    swap(array, i, j);
    delay(delay);
  }
}
