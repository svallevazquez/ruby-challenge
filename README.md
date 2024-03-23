As the intention of this test is doing it with Ruby and not relying in a database, I will create a little Ruby gem project.

But as I love the new technologies and as a way of preparing a project for production environment, this project will use Kubernetes and Helm.

# Little Warnings
* This gem contains a models folder but none ot the classes there are ActiveRecord ones, neither related to storing into database (as this gem is not interanting with any database or storing system)

# Local deployment
I will create with Kind command for local a new cluster and setting a configuration for creating a volume and use this project, so in this project will
be an script for creating and updating the release of this project in local.

You can check `install.sh` script for more information.

# Planning of the challenge
We will start trying to do TDD and creating an structure for the different elements, like:
* SEGMENT class (**PARENT CLASS**)-> for each entry or booking that we have. Which contains the next info:
  * Origin
  * Destination
  * Upcoming time
  * Departure time

**The intention is creating another classes like Segments::Flight, Segments::Hotel and Segments::Train. As Train and Flight would be almost the same, we will create another class called Segments::Transport for being the parent class of these last two.**

* TRIP class -> that will contain all segments related to the same trip
  * Origin
  * Starting time
* SVQ Parser class -> it will be a service for parsing to the other classes
* SVQ Validator class -> another service for validating the format of SVQ format
* Arguments Validator class -> service for validating the arguments and env variable with their values
We will need something that could be easy to understand for external people, and production ready.
My first conclusion is creating some recursive method or class for checking the things.

**And remember trying not to create innecessary loops**