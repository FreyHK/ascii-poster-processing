import processing.pdf.*;

PImage img;

String textFilename = "pride.txt";
String text; 

String fontName = "RobotoMono.ttf";

Boolean export = false;
String exportFilename;

int renderWidth = 600;
int renderHeight = 600;

void settings () {
  if (export) {
    exportFilename = "exports/" + day() + "-" + month() + "-" + hour() + "-" + minute() + floor(random(0, 100000)) + ".pdf"; 
    size(renderWidth, renderHeight, PDF, exportFilename);
  }else {
    size(renderWidth, renderHeight);
  }
}

void setup () {
  img = loadImage("skull-200.jpg"); 
  
  String[] lines = loadStrings(textFilename);
  text = "";
  for (int i = 0; i < lines.length; i++) {
    text += lines[i];
  }
  if (export) {
    textMode(SHAPE);
  }else {
    drawAscii ();
  }
}

void draw () {
  if (export) {
    drawAscii ();
    println("Exported file to: " + exportFilename);
    exit();
  }
}

void drawAscii () {
  background(#f6f6f6);
  
  img.loadPixels();
  
  PFont font = createFont(fontName, 8);
  textFont(font);
  
  int w = width/img.width;
  int h = height/img.height;
  int charIndex = 0;

  for (int r = 0; r < img.height; r++) {
    for (int c = 0; c < img.width; c++) {
      
      int col = img.pixels[c + r * img.width ];
      
      float hue = hue(col);
      float sat = saturation(col);
      float bright = brightness(col);
      
      colorMode(HSB);
      
      fill(color(hue, sat, bright));
      
      char ch = text.charAt(charIndex % text.length());
      text(ch, c * w, r * h + h);
      
      //println(charIndex + ": " + ch);
      charIndex++;
    }
  }
}
