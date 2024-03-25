As the intention of this test is doing it with Ruby and not relying in a database, I will create a little Ruby gem project.

But as I love the new technologies and as a way of preparing a project for production environment, this project will use Kubernetes and Helm.

**I created a Dockerfile for the people that preffers another posibility, but as it was not the initial idea it is a simple one**


# Little Warnings
* This gem contains a models folder but none ot the classes there are ActiveRecord ones, neither related to storing into database (as this gem is not interanting with any database or storing system)


# Local deployment
I will create with Kind command for local a new cluster and setting a configuration for creating a volume and use this project, so in this project will
be an script for creating and updating the release of this project in local.

You can check `install.sh` script for more information.

**At first, it will install kind (for working with K8s in local) and k9s (dashboard)**


# Planning of the challenge
We will start trying to do TDD and creating an structure for the different elements, like:
* SEGMENT class (**PARENT CLASS**)-> for each entry or booking that we have. Which contains the next info:
  * Origin
  * Destination
  * From Time
  * To Time

**The intention is creating another classes like Segments::Flight, Segments::Hotel and Segments::Train. As Train and Flight would be almost the same, we will create another class called Segments::Transport for being the parent class of these last two.**

* TRIP class -> that will contain all segments related to the same trip
  * Segments associated to the trip
* SVQ Parser class -> it will be a service for parsing to the other classes
We will need something that could be easy to understand for external people, and production ready.
My first conclusion is creating some recursive method or class for checking the things.

**And remember trying not to create innecessary loops**


# Things that can be improved in future updated
* A refactor and new classes for RubyChallenge::SvqParser
* Change type of from_time and to_time to Date instead of Time (but then we will need a change for the sorting process of the segments into a trip)
* Adding a log
* Rename from_time and to_time attributes with other names, more friendly


# Final explanation and thoughts
It was my first time playing with the GitHub actions for CI, as usually I am using GitLab, but it was pretty intuitive and very good for learning more things.

About why using Kind for local environment, it is because I recently created this other way in my laptop and is helping me so much that I wanted to try it again. This is much faster than docker compose in my experience for local projects, and has a lot of other benefits as working with Kubernetes (trending topic these days).

And finally, I wanted to create code where the comments are not necesary, as the methods, classes and all parts are friendly naming. So I hope that whoever reads the code of this project could undestand it well and enjoy it.
