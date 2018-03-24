---
title: 'Code Clinic Problem 4: Musical Instrument'
author: "Mark Niemann-Ross"
date: "March 21, 2018"
output: html_document
---

Hello, and welcome to the fourth problem of the Code Clinic Series.

This is a challenge to build a musical instrument controlled by the computer mouse.
The concept is easy, but execution is difficult because many computer languages insulate the language from the hardware of the computer.

This has the advantage of allowing one program to run on multiple computers without modifications.

It has the disadvantage of making it difficult to access hardware that isn't available through the operating system.

This challenge will illustrate this difference between different languages. Some will have absolutely no problem – some will find it impossible.

Here's the challenge. Create a computer program that converts mouse movements into musical pitches.

The instrument should be silent until one of the mouse buttons is held down
- Move the mouse up and down to change the pitch.
- Move the mouse side to side to change the volume.
- Let go of the mouse button and the musical tone stops.

This seems like a simple request. But it requires access to the mouse and speaker, which may make it difficult or impossible in some languages.

Even if it's impossible, the author will explain the problem and attempt to offer an alternative way to make it work.

Thomas Edison observed “Negative results are just what I want. They’re just as valuable to me as positive results. I can never find the thing that does the job best until I find the ones that don’t.”

Before you go any further, take some time and solve the problem yourself. You'll get a better appreciation for the challenge our authors face.

OK authors. Let's make some noise!

mnr notes:
- there doesn't appear to be any way to write a wav file that includes amplitude - only frequency.
- I can capture x and y data from the mouse using tcl/tk

