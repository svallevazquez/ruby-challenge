As the intention of this test is doing it with Ruby and not relying in a database, I will create a little Ruby gem project.
But as I love the new technologies and as a way of preparing a project for production environment, this project will use Kubernetes and Helm.

# Local deployment
I will create with Kind command for local a new cluster and setting a configuration for creating a volume and use this project, so in this project will
be an script for creating and updating the release of this project in local.
You can check `install.sh` script for more information.
