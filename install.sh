# Exit when any command fails
set -e

# Constants or variables for script execution
CLUSTER_NAME="ruby-challenge-local"
KIND_CLUSTER="kind-$CLUSTER_NAME"
REPO_PATH=$(pwd)
KIND_CONFIG_FILEPATH="$REPO_PATH/kind-config.yaml"
KIND_CONFIG_TEMPLATE_FILEPATH="$REPO_PATH/kind-config.yaml.default"
NAMESPACE="local-challenge"
HELM_RELEASE="challenge-release"

# Creation of new configuration file if you don't already have one
if [ -f "$KIND_CONFIG_FILEPATH" ]; then
  echo "Kind configuration file already exists"
else
  cp "$KIND_CONFIG_TEMPLATE_FILEPATH" "$KIND_CONFIG_FILEPATH"
  sed -i -e "s|REPO_PATH|$(pwd)|g" "$KIND_CONFIG_FILEPATH"
  echo "Kind configuration file created"
fi

# If the cluster is already created
if kubectl config get-contexts | grep -q $KIND_CLUSTER; then
  echo "Kind cluster already exists"
else
  # Creating and setting configuration for cluster
  kind create cluster --name $CLUSTER_NAME --config=$KIND_CONFIG_FILEPATH
fi

# Setting the context to the new cluster
kubectl config use-context $KIND_CLUSTER

# Check if namespace is already created
if kubectl get namespaces | grep -q "$NAMESPACE"; then
  echo "Namespace $NAMESPACE already exists"
else
  # Create namespace
  kubectl create namespace $NAMESPACE
fi

# If the release of helm was done, we remove it
helm uninstall "$HELM_RELEASE" --ignore-not-found

# Create release
helm install --replace "$HELM_RELEASE" ./kubernetes

# Suggestion
echo "FINISHED"
echo "Remember to use the dashboard with K9s for a friendly experience (you can install it with 'brew install k9s')"
echo "k9s --context $KIND_CLUSTER"