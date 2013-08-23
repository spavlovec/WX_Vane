int dipPins[] = {0, 1, 2, 3, 4};  //An array to receive a binary 6-bit number on not necessarily consecutive pins, ordered by LSb to MSb

const int table[] = { -1,  0, 72, 12,144,132, 84,120,
               216,348,204, 24,156,168,192,180,
               288,300, 60, 48,276,312, 96,108,
               228,336,240, 36,264,324,252, -1};

             //       { -1,250,320,260, 40,240,340,230,
            //   110,100,310,280, 50, 60,300,290,
            //   180,190,170,160, 20,200,350,220,
            //   120, 80,130,140, 10, 70,  0, -1};
int wind;

void setup()
{
Serial.begin(9600); // sets the serial port to 9600
 for(int i = 0; i < 5; i++)
  {
    pinMode(dipPins[i], INPUT);
  }
}

void loop()
{
  int state = parallelToByte();
  wind = table[state];
    Serial.println(wind); // prints the value read
    delay(3000); // wait 10ms for next reading
} 

int parallelToByte()
{
  int ret = 0;  // Initialize the variable to return
  int bitValue[] = {1,2,4,8,16};  // bit position decimal equivalents
  for(int i = 0; i < 5; i++)  // cycle through all the pins
  {
    if(analogRead(dipPins[i]) > 10)  // because all the bits are pre-loaded with zeros, only need to do something when we need to flip a bit high
    {
      ret = ret + bitValue[i];  // adding the bit position decimal equivalent flips that bit position
    }
  }
  return ret;
}

