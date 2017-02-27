int[] items;
int scl;
boolean done = false;
int gap;
float shrink = 1.2f;
boolean sorted = false;

void setup(){
  size(1200, 800);
  items = new int[600];
  scl = width / items.length;
  for(int i = 1; i < items.length; i++){
    items[i] = items.length - i;
  }
  shuffle(items);
  gap = items.length;
  frameRate(60);
}

void draw(){
  noStroke();
  background(0);
  for(int i = 1; i < items.length; i++){
    rect((i) * scl, height - items[i], scl, items[i]);
  }
  if(!sorted){
    gap = floor(gap/shrink);
    if(gap > 1){
      sorted = false;
    }else{
      gap = 1;
      sorted = true;
    }
    for(int i = 0; i + gap < items.length; i++){
      if(items[i] > items[i + gap]){
        swap(items, i, i + gap);
        sorted = false;
      }
    }
  }
}


void swap(int[] array, int a, int b){
  int temp = array[a];
  array[a] = array[b];
  array[b] = temp;
}

void shuffle(int[] array){
  for(int i = 0; i < array.length; i++){
    swap(array, i, floor(random(array.length - 1)));
  }
}
