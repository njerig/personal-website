---
title: This is a Test
description: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
date: 2020-01-23
draft: true
---

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.[^1]

## A Quote
> Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
> Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

### The Important Code
```cpp
/*
 *  njerig
 *  Occupancy Sensing
 *  (works with PIR and reed sensor)
*/


#include <ESP8266WiFi.h>
#include <Ticker.h>
#include <AsyncMqttClient.h>
#include <SoftwareSerial.h>

#include "config.h"

/*
   CONFIG VARS
*/
// name used to identify this esp8266 to mqtt broker

const char* CLIENT_ID = client_id;
// wifi stuff
const char* WIFI_SSID = wifi_ssid;
const char* WIFI_PASSWORD = wifi_password;
// mqtt broker ip address or url
const IPAddress MQTT_BROKER = mqtt_broker;
const int MQTT_PORT = mqtt_port;
// topic to subscribe to?
const char* IN_TOPIC = in_topic;
// topic to publish to
const char* OUT_TOPIC = out_topic;

const int BAUD_RATE = 9600;
const int SENSOR_PIN = 13;
const int LED_PIN = 2;

AsyncMqttClient mqttClient;
Ticker mqttReconnectTimer;

WiFiEventHandler wifiConnectHandler;
WiFiEventHandler wifiDisconnectHandler;
Ticker wifiReconnectTimer;

SoftwareSerial ESPserial(2, 3);

// initialize state vars
int currentOccupancyState = 0;
int lastOccupancyState = 0;

void setup() {
    Serial.begin(BAUD_RATE);
    ESPserial.begin(115200);
    ESPserial.println("AT+IPR=9600");
    delay(1000);
    ESPserial.end();
    ESPserial.begin(9600);
    Serial.println("serial ready");
    ESPserial.println("AT+GMR");

    pinMode(SENSOR_PIN, INPUT);
    pinMode(LED_PIN, OUTPUT);

    wifiAndMqttSetup();

    Serial.println("Motion detection starting now.");
}

void loop() {

    currentOccupancyState = digitalRead(SENSOR_PIN);

    publishCurrentState(currentOccupancyState);

    if (currentOccupancyState != lastOccupancyState) {
        if (currentOccupancyState == HIGH) {
            Serial.println("occupied");
        } else {
            Serial.println("vacant");
        }
        digitalWrite(LED_PIN, !currentOccupancyState);   // onboard LED turns on when LOW
    }
    // update last state
    lastOccupancyState = currentOccupancyState;
}
```

And by the way, here's inline css: `body { color:blue; }`.

## Subheading
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

### Sub-subheading
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

[^1]: Some footnote
