#include <Wire.h>
#include <INA226.h>
#include "TimerOne.h"
unsigned int counter=0;

INA226 ina;

// Motor 1
int dir1PinA = 3;
int dir2PinA = 4;
int speedPinA = 9; // Needs to be a PWM pin to be able to control motor speed
 
void checkConfig()
{
  Serial.print("Mode:                  ");
  switch (ina.getMode())
  {
    case INA226_MODE_POWER_DOWN:      Serial.println("Power-Down"); break;
    case INA226_MODE_SHUNT_TRIG:      Serial.println("Shunt Voltage, Triggered"); break;
    case INA226_MODE_BUS_TRIG:        Serial.println("Bus Voltage, Triggered"); break;
    case INA226_MODE_SHUNT_BUS_TRIG:  Serial.println("Shunt and Bus, Triggered"); break;
    case INA226_MODE_ADC_OFF:         Serial.println("ADC Off"); break;
    case INA226_MODE_SHUNT_CONT:      Serial.println("Shunt Voltage, Continuous"); break;
    case INA226_MODE_BUS_CONT:        Serial.println("Bus Voltage, Continuous"); break;
    case INA226_MODE_SHUNT_BUS_CONT:  Serial.println("Shunt and Bus, Continuous"); break;
    default: Serial.println("unknown");
  }
 
  Serial.print("Samples average:       ");
  switch (ina.getAverages())
  {
    case INA226_AVERAGES_1:           Serial.println("1 sample"); break;
    case INA226_AVERAGES_4:           Serial.println("4 samples"); break;
    case INA226_AVERAGES_16:          Serial.println("16 samples"); break;
    case INA226_AVERAGES_64:          Serial.println("64 samples"); break;
    case INA226_AVERAGES_128:         Serial.println("128 samples"); break;
    case INA226_AVERAGES_256:         Serial.println("256 samples"); break;
    case INA226_AVERAGES_512:         Serial.println("512 samples"); break;
    case INA226_AVERAGES_1024:        Serial.println("1024 samples"); break;
    default: Serial.println("unknown");
  }
 
  Serial.print("Bus conversion time:   ");
  switch (ina.getBusConversionTime())
  {
    case INA226_BUS_CONV_TIME_140US:  Serial.println("140uS"); break;
    case INA226_BUS_CONV_TIME_204US:  Serial.println("204uS"); break;
    case INA226_BUS_CONV_TIME_332US:  Serial.println("332uS"); break;
    case INA226_BUS_CONV_TIME_588US:  Serial.println("558uS"); break;
    case INA226_BUS_CONV_TIME_1100US: Serial.println("1.100ms"); break;
    case INA226_BUS_CONV_TIME_2116US: Serial.println("2.116ms"); break;
    case INA226_BUS_CONV_TIME_4156US: Serial.println("4.156ms"); break;
    case INA226_BUS_CONV_TIME_8244US: Serial.println("8.244ms"); break;
    default: Serial.println("unknown");
  }
 
  Serial.print("Shunt conversion time: ");
  switch (ina.getShuntConversionTime())
  {
    case INA226_SHUNT_CONV_TIME_140US:  Serial.println("140uS"); break;
    case INA226_SHUNT_CONV_TIME_204US:  Serial.println("204uS"); break;
    case INA226_SHUNT_CONV_TIME_332US:  Serial.println("332uS"); break;
    case INA226_SHUNT_CONV_TIME_588US:  Serial.println("558uS"); break;
    case INA226_SHUNT_CONV_TIME_1100US: Serial.println("1.100ms"); break;
    case INA226_SHUNT_CONV_TIME_2116US: Serial.println("2.116ms"); break;
    case INA226_SHUNT_CONV_TIME_4156US: Serial.println("4.156ms"); break;
    case INA226_SHUNT_CONV_TIME_8244US: Serial.println("8.244ms"); break;
    default: Serial.println("unknown");
  }
 
  Serial.print("Max possible current:  ");
  Serial.print(ina.getMaxPossibleCurrent());
  Serial.println(" A");
 
  Serial.print("Max current:           ");
  Serial.print(ina.getMaxCurrent());
  Serial.println(" A");
 
  Serial.print("Max shunt voltage:     ");
  Serial.print(ina.getMaxShuntVoltage());
  Serial.println(" V");
 
  Serial.print("Max power:             ");
  Serial.print(ina.getMaxPower());
  Serial.println(" W");
}

void docount()  // counts from the speed sensor
{
  counter++;  // increase +1 the counter value
} 

void timerIsr()
{
  Timer1.detachInterrupt();  //stop the timer
  Serial.print("Motor Speed: "); 
  int rotation = (counter / 1);  // divide by number of holes in Disc
  Serial.print(rotation,DEC);  
  Serial.println(" Rotation per seconds"); 
  counter=0;  //  reset counter to zero
  Timer1.attachInterrupt( timerIsr );  //enable the timer
}
 
void setup()
{
  Serial.begin(9600);
  pinMode(dir1PinA,OUTPUT);
  pinMode(dir2PinA,OUTPUT);
  pinMode(speedPinA,OUTPUT);
  
  Serial.println("Initialize INA226");
  Serial.println("-----------------------------------------------");
 
  // Default INA226 address is 0x40
  ina.begin();
 
  // Configure INA226
  ina.configure(INA226_AVERAGES_1, INA226_BUS_CONV_TIME_1100US, INA226_SHUNT_CONV_TIME_1100US, INA226_MODE_SHUNT_BUS_CONT);
 
  // Calibrate INA226. Rshunt = 0.01 ohm, Max excepted current = 4A
  ina.calibrate(0.01, 4);
 
  // Display configuration
  checkConfig();
 
  Serial.println("-----------------------------------------------");
  Serial.println("   ");
  Serial.println("   ");
  Serial.println("   ");
  Serial.println("   ");
  
  Timer1.initialize(1000000); // set timer for 1sec
  attachInterrupt(0, docount, RISING);  // increase counter when speed sensor pin goes High
  Timer1.attachInterrupt( timerIsr ); // enable the timer

  Serial.print("Time:  ");
  Serial.print("Bus voltage:  "); 
  Serial.print("Bus power:  "); 
  Serial.print("Shunt voltage: ");
  Serial.println("Shunt current: ");
}
 
void loop()
{
  Serial.print(millis());
  Serial.print(ina.readBusVoltage(), 5);
  Serial.print(ina.readBusPower(), 5);
  Serial.print(ina.readShuntVoltage(), 5);
  Serial.print(ina.readShuntCurrent(), 5);
  delay(1000);
  if (Serial.available() > 0) {
int inByte = Serial.read();
int speed; // Local variable

switch (inByte) {

//______________Motor 1______________

case '1': // Motor 1 Forward
analogWrite(speedPinA, 255);//Sets speed variable via PWM 
digitalWrite(dir1PinA, LOW);
digitalWrite(dir2PinA, HIGH);
Serial.println("Motor 1 Forward"); // Prints out “Motor 1 Forward” on the serial monitor
Serial.println("   "); // Creates a blank line printed on the serial monitor
break;

case '2': // Motor 1 Stop (Freespin)
analogWrite(speedPinA, 0);
digitalWrite(dir1PinA, LOW);
digitalWrite(dir2PinA, HIGH);
Serial.println("Motor 1 Stop");
Serial.println("   ");
break;

case '3': // Motor 1 Reverse
analogWrite(speedPinA, 255);
digitalWrite(dir1PinA, HIGH);
digitalWrite(dir2PinA, LOW);
Serial.println("Motor 1 Reverse");
Serial.println("   ");
break;
}
  }
}
