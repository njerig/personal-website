---
layout: project
title: S.O.S.
description: How do you know if the showers or toilet stalls down the hall are occupied? S.O.S., a Shower/Stall Occupancy System, allowed anyone on the local network to check a website when they wanted to know occupancy status. 
start_date: 2016-01-01
end_date: 2018-06-01
tags: arduino c++ python flask
---

## Introduction

S.O.S. was born out of a small, recurring issue I ran into while living in a dorm at MIT. Oftentimes, just when I stopped what I was doing to take a shower, I'd walk into the bathroom and both shower stalls were occupied. Sometimes, I'd even walk down the hall to the next bathroom and those showers, too, were occupied. I talked to a few hall mates about this and they also encountered the same problem frequently enough to mention it. 

Inspired by the laundry machine server my dorm had (which showed which washers and dryers were in use) and bathroom occupancy signs on planes, I thought to myself: How could I build a system that would allow us to know whether the showers and toilets were in use?

I got to work.

## System design

To design the system, I started with thinking about how I wanted people to access occupancy data. A few choices were:
1. looking at signs on top of the bathroom door that can be seen when walking down the hall
2. viewing an icon that sits either in your menu bar (on Macs) or task bar (on Windows) that shows status of favorited stalls
3. going to a website

Although I wanted to build all of them, I chose #3 for its simplicity. Additionally, the system I'd build for #3 was the most extensible and would allow me to build #1 and #2 down the road.

My choice meant I needed a central node that receives occupancy data from all stalls and hosts a web server with a page displaying occupancy status, as well as several sensor nodes that gather occupancy data.

## Electronics

First, I needed to determine what sensors to use. While choosing the toilet stall sensors was straightforward (magnetic contact sensors), I recall having some trouble figuring out which sensors to use for the shower. I had a conversation with one particular hall mate about this, and she mentioned thinking about building a system like this once and told me to consider humidity sensors. We talked about possibly using some kind of water sensor, but
1. I knew I wanted to try and avoid the electronics touching water, and
2. noticed that a stall can still be occupied without water being present. (What if someone is putting on or taking off clothes?)

Relying on sensor knowledge from high school robotics, I thought my best bet was to use motion sensors – specifically, passive infrared sensors.

I then needed to determine what microcontroller would drive the sensor node. I was primarily looking for something cheap (just in case I needed to replace electronics due to water vapor seeping in) and something with Wi-Fi onboard. Luckily, I found the WeMos D1 Mini, a cheap ESP8266 board (at the time, around $2-$3 per board). Additionally, I decided I was going to use an MIT server to host the central node's web server.

The rest of the components included water-tight boxes for shower sensor nodes, power cables, and basic circuit components (wire, resistors, etc).

## Software

Next, I needed to decide how to build the software layer. 

### Central node

I knew I wanted bi-directional communication between the central node and the sensor nodes, so I chose to use MQTT, a lightweight messaging protocol for Internet-of-Things devices. The web server itself was a Flask server. I used SocketIO for real-time updates between the web client and web server.

### Sensor nodes

The WeMos D1 Mini can be programmed using Arduino, so that's what I wrote C++ code in. The code was pretty simple. For setup, the sensor nodes just needed to connect to the local Wi-Fi network and MQTT daemon; in the main loop, it publishes occupancy status when the last sampled status is different from the current status.

## Reflection

- The hardest part was figuring out how long the power cables needed to be.
- I think a fully built system would include the other two status access options I described in the beginning (a sign on top of the bathroom door and a small, out-of-the-way program that would show you the occupancy status of a favorited shower and toilet stall). Sadly, I didn't get to build these.

## Links
- Sensor node code: [https://github.com/njerig/sos-sensor-node](https://github.com/njerig/sos-sensor-node)
- Boilerplate central node code: [https://github.com/njerig/flask-socketio-mqtt-server](https://github.com/njerig/flask-socketio-mqtt-server)