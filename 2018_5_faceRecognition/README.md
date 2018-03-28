---
title: "facial recognition"
author: "Mark Niemann-Ross"
date: "March 24, 2018"
output: html_document
---

Hello, and welcome to the fifth problem of the Code Clinic Series.

This is a challenge to find faces in a photograph.

Fifty years ago, this problem would have difficult or impossible. The technology and algorithims for facial recognition were just being created.

Trying to recognize a face in a photograph but failing. Clock insert counts down the time.
Computers were barely powerful enough to run the algorithms and it could take hours to recognize one face.

Today, we have real-time performance and use it as a security device in some mobile computers.

In this challenge, we're asking our authors to demonstrate how to do this with their programming language.

We've challenged our authors to create a function that does the following:

- First, the function should accept a jpeg, gif or png file of varying dimensions.
- Their function should then identify the number of faces in that image. There may not be any faces in the image, in which case the function should return zero.
- If the author chooses to go for extra credit, their function can create a copy of the image with the faces visually identified, either with a surrounding box or other method.

The function should return a JSON file with two fields: countFaces and imageLocation
{
   "countFaces" : 3,
   "imageLocation" : "file.jpg"
}

Before you go any further, take some time and solve the problem yourself. You'll get a better appreciation for the challenge our authors face.

Ok authors. Let's find out who's who.

