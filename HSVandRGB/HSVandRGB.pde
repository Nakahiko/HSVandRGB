float x = 0;
float y;

int hue = 0;
float[] hues;
float[] hr;
float[] hg;
float[] hb;
int ih;
int nh = 360;

color colorW;
PFont fontL;

void setup() {
  
  size(640, 640);
  
  hues = new float[ nh ];
  hr = new float[ nh ];
  hg = new float[ nh ];
  hb = new float[ nh ];
  ih = nh;
  
  colorMode(RGB, 255);
  colorW = color( 255 );
  
  fontL = createFont( "HelveticaNeue-Bold", 64 );
  textAlign( RIGHT, BOTTOM );
  background(0);
  noStroke();
}

void draw() {
  background(0);
  
  hue = ++hue % nh;
  ih = ++ih % nh;
  
  hues[ ih ] = (float)hue / 360;

  int[] rgb = HSVtoRGB(hue, 255, 255);
  hr[ ih ] = (float)rgb[0]/255;
  hg[ ih ] = (float)rgb[1]/255;
  hb[ ih ] = (float)rgb[2]/255;

  colorMode(HSB, 360, 100, 100);

  {
    int left_t = 50;
    int right_t = 300;
    int width_t = right_t - left_t;

    int top_t = 80;
    int bottom_t = 90;

    strokeWeight( 1 );
    for (int i = 0; i < width_t; i++ ) {
      stroke( i * ( 360.0 / width_t ), 100, 100 );
      line( left_t + i, top_t, left_t + i, bottom_t );
    }

    stroke( colorW );
    fill( colorW );
    int x = (int)(left_t + hue / ( 360.0 / width_t ));
    triangle(x - 10, top_t-17, x + 10, top_t-17, x, top_t);
  }

  rectMode(CORNERS);
  noStroke();
  fill(hue, 100, 100);
  rect(50, 120, 300, 220);
  
  
  //----------------------------三つの円
  colorMode(RGB, 255);
  blendMode(ADD);
  
  stroke(colorW);
  
  fill( hr[ ih ]*255, 0, 00 );
  ellipse(450,108,100,100);
  
  fill( 0, hg[ ih ]*255, 0 );
  ellipse(422,170,100,100);
  
  fill( 0, 0, hb[ ih ]*255 );
  ellipse(478,170,100,100);
  
  blendMode(BLEND);
  
  //----------------------------HSVのグラフ表示
  colorMode(HSB, 360, 100, 100);
  stroke(hue, 100, 100);
  drawGraph(hues, new Rect(50, 275, 400, 375));
  fill(hue, 100, 100);
  drawInfo(hues[ ih ], 580, 335);
  
  
  //----------------------------RGBのグラフ表示
  colorMode(RGB, 255);
  
  stroke( 200, 100, 80 );
  drawGraph(hr, new Rect(50, 350, 400, 450));
  fill( 200, 100, 80 );
  drawInfo(hr[ ih ], 580, 410);

  stroke( 80, 200, 100 );
  drawGraph(hg, new Rect(50, 425, 400, 525));
  fill( 80, 200, 100 );
  drawInfo(hg[ ih ], 580, 485);

  stroke( 100, 80, 200 );
  drawGraph(hb, new Rect(50, 500, 400, 600));
  fill(  100, 80, 200 );
  drawInfo(hb[ ih ], 580, 560);
}

void drawGraph(float[] ar, Rect pos) {

  int center_y = pos.top + pos.getHeight() / 2;
  float m_t = (float)pos.getWidth() / ar.length;

  noFill();
  strokeWeight( 3 );
  strokeJoin( ROUND );
  strokeCap( ROUND );

  //グラフ曲線
  beginShape();
  for ( int i = 0; i < ar.length; i ++ ) {
    int index = ( ih + i + 1 ) % nh;
    vertex( pos.left + i * m_t, center_y - ar[ index ] * (pos.getHeight()/2) );
  }
  endShape();

  noStroke();
}



void drawInfo(float val, int x, int y) {
  textFont( fontL );
  text( val, x, y );
}

int[] HSVtoRGB(int h, int s, int v) {
  float f;
  int i, p, q, t;
  int[] rgb = new int[3];

  i = (int)Math.floor(h / 60.0f) % 6;
  f = (float)(h / 60.0f) - (float)Math.floor(h / 60.0f);
  p = (int)Math.round(v * (1.0f - (s / 255.0f)));
  q = (int)Math.round(v * (1.0f - (s / 255.0f) * f));
  t = (int)Math.round(v * (1.0f - (s / 255.0f) * (1.0f - f)));

  switch(i) {
  case 0 : 
    rgb[0] = v; 
    rgb[1] = t; 
    rgb[2] = p; 
    break;
  case 1 : 
    rgb[0] = q; 
    rgb[1] = v; 
    rgb[2] = p; 
    break;
  case 2 : 
    rgb[0] = p; 
    rgb[1] = v; 
    rgb[2] = t; 
    break;
  case 3 : 
    rgb[0] = p; 
    rgb[1] = q; 
    rgb[2] = v; 
    break;
  case 4 : 
    rgb[0] = t; 
    rgb[1] = p; 
    rgb[2] = v; 
    break;
  case 5 : 
    rgb[0] = v; 
    rgb[1] = p; 
    rgb[2] = q; 
    break;
  }

  return rgb;
}