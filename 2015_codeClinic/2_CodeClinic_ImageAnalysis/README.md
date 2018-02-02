---
title: "Code Clinic: R image analysis"
author: "Mark Niemann-Ross"
date: "December 5, 2014"
output: html_document
---

Code Clinic is a monthly course where a unique problem is introduced to a collection of lynda.com authors. In response, each author will create a solution using their programming language of choice. You can learn several things from Code Clinic: different approaches to solving a problem, the pros and cons of different languages, and some tips and tricks to incorporate into your own coding practices.

we’ll work on a problem centered around image analysis. In one sense, this is simply data analysis - images are really nothing more than specialized and well-defined sets of data. 

 An image consists of pixels. Pixels consist of data representing the color of the pixel and in some cases, the pixel’s transparency. When assembled correctly, they represent an image.

Our brains are very good at recognizing patterns - but computers are not. Think about captcha security devices - those puzzles you sometimes see when logging into a website. The Captcha asks what letters and numbers are in the image - information obscured by random lines, sometimes overlapping transparent blocks of color. All of those intersecting shapes makes it difficult for a computer program to separate the background noise from the actual data.

Another example is the tests to determine color-blindness. Letters and numbers are hidden in a circle filled with different color dots. If you are color-blind, you will not be able to see the numbers. For a computer program, this can be incredibly difficult as it requires detecting an edge, as well as recognizing the overall shape. It’s difficult, even for the most advanced programmer.

In this problem, we’re trying to solve a common problem for many photographers - plagiarism. A photographer will take a picture and post it on the internet, only to discover someone has stolen their image and placed a subset of that image on their website.
screen capture of scrolling through google images

It would be extremely handy if there was a program searching the internet for cropped versions of an original image so that a photographer could protect their rights. In fact, [http://www.google.com/insidesearch/features/images/searchbyimage.html
](google image search) will do just that - but we’re curious how it works and what the required code might look like.

Here’s the challenge; given two images, determine if one image is a subset of the other image. 

We’ll assume they are both jpeg files, that the resolution is the same as well as the bit depth. 





