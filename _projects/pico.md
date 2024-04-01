---
layout: project
title: Pico
subtitle: How can I make the course selection process easier?
description: Pico is a browser extension that streamlines the SMC course selection process by adding critical course and professor data to the class search page.
start_date: 2023-07-01
tags: forcorsairs javascript typescript next.js html css postgresql
---

## Introduction

Pico was born out of an inconvenience I experienced when looking for classes to take at SMC.

Something that is known by most SMC students is that, when choosing a section of a class to enroll in, you look for / at
1. whether the section fits your schedule (by looking at the [class search site](https://smc.edu/searchclasses))
2. what the professor's ratings are (by checking [RateMyProfessors](https://www.ratemyprofessors.com/school/1371))
3. the professor's grade distribution for the class you're searching for and / or other classes they teach (by checking the [grade distribution PDFs](https://www.smc.edu/administration/institutional-research/grade-distribution.php))

Selecting classes in this way can take a moderate amount of effort, so I naturally wanted to streamline this process (and give back to the school in some way).

## System Design

My first tendency when making web-based projects is to make a website, since it's something I've been knowing how to do since I was nine. I talked with a friend about the idea I had (hi Yafei!) – to build a website that would include all of this information on one site. She showed me a USC professor's browser extension that she said was very helpful when registering for classes. I had never made a browser extension before, but I realized I ultimately wanted to reduce the number of tabs a student had to switch between when choosing classes. I knew that students were already going to visit the class search page to check schedules and status of classes, so I decided against building a website (which would require students to have two tabs open) and went with building a browser extension. I'd name it Pico based on the street SMC is on (Pico Boulevard).

Pico would inject critical information to the class search process into the class search page. Specifically, I wanted it to inject professor ratings, professor sentiment amongst previous students, and grade distribution data.

The actual design of the system unfolded naturally from picking the form factor; there is a structure inherent to building a browser extension. I also was interested in supporting as many browsers as possible, so I decided to use [webextension-toolbox](https://github.com/webextension-toolbox/webextension-toolbox) to build the extension.

## The Beta

Since I wanted to ship quickly, I decided to start off by injecting professor ratings. After looking into RateMyProfessor - its API, and any related open-source libraries – I found a [TypeScript RateMyProfessors library](https://github.com/MichiganTechCourses/rate-my-professors). I forked the repository and added some functionality to it. In the process, I learned TypeScript and GraphQL for the first time.

I was taking classes in summer and fall, and had to learn new technologies (how to build browser extensions, more advanced JavaScript, TypeScript, and basic GraphQL), so it took me longer than I expected to finish the beta. I released it on October 9, 2023 to the SMC Computer Science Club.

## forcorsairs

I specifically released it to the Computer Science Club for two reasons: to find bugs, and to garner interest in helping me build v1. Thus, a informal student software development group was born: forcorsairs.

## v1
For v1, I want to add grade distribution data to Pico. We are currently working on the infrastructure required for v1:
- [x] some way of notifying us when new grade distributions are posted
- [ ] a PDF processing pipeline (almost done),
- [ ] a database to store the grade distribution data,
- [ ] a server with a REST API to serve the data to my extension

To be continued...