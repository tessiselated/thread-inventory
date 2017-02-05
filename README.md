# Thread Inventory

This project is a personal inventory management for embroidery threads, specifically DMC threads.

It has individual login, where a user can populate a personal their personal inventory and a personal shopping list. They are also able to open projects and indicate what threads will be used by a project. It will then prompt the user to add threads to the shopping list - and indicates which threads (and how much) are currently in the inventory.

Threads can be marked as "bought" from the shopping list which will then add them to the inventory. The inventory view will also show which threads are currently in use by a project - indicating that the amount may be out of date.

Users can close a project, which will prompt the user to update the amount of each thread left in the inventory.

## Environments

thread inventory was developed with
- OS X El Capitan v 10.11.6
- ruby 2.3.1
- sinatra 1.4.7
- pg 0.19.0

## Installation

To use this application, download this repo and run `bundle install`. You will need a local postgres client

Alternatively, it is [hosted on Heroku](https://fast-bayou-63859.herokuapp.com/entrypage)

## Discussion

Thread Inventory (better name pending) is my first full stack ruby application, and represents a huge learning curve. This project really helped me to understand how OOP can be used. It also took me a while to understand the data structure I wanted to use - it was one thing to have belongs_to and has_many and join tables explained, but it took me a while to wrap my head around implementing them.

Some things I'd like to add when I have time
- Mobile responsiveness - this project was born out of me getting frustrated about forgetting which threads I had and needed when I was at the store. To be able to check this it needs to look better on mobile
- User controls - such as the ability to change password, send a forgotten password request etc
- The ability to edit any open projects, and maybe archiving closed projects instead of deleting them.

## Licence

Copyright 2017

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
