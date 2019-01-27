#!/bin/bash

# Execute in script dir
cd $(dirname ${0})
# secret-service-app
SERVICE_NAME="swagger"
SECRET_SERVIVE="secret-${SERVICE_NAME}"
VERSION='3.13.4'
GIT_URL='git@github.com:cchet-thesis-msc/prototype.git'
GIT_REF=${GIT_REF:-'master'}
CONTEXT_DIR='docker/swagger-ui/'

# tag::broken-function[]
function createSecrets() {
  oc create secret generic ${SECRET_SERVIVE}
    --from-file=ssh-privatekey='${HOME}/.ssh/id_rsa'
}
# end::broken-function[]

function deleteSecrets() {
  oc delete secret/${SECRET_SERVIVE}
}

function createService() {
  oc new-app -f ./swagger-full.yml \
    -p "SERVICE_NAME=${SERVICE_NAME}" \
    -p "VERSION=${VERSION}" \
    -p "GIT_URL=${GIT_URL}" \
    -p "GIT_REF=${GIT_REF}" \
    -p "CONTEXT_DIR=${CONTEXT_DIR}" \
    -p "SECRET_GIT=${SECRET_SERVIVE}"
} # createBc

function deleteService() {
    oc delete all -l app=${SERVICE_NAME}
}

# tag::newfunction[]
function recreateService() {
  deleteService
  createService
}
# end::newfunction[]

function createAll() {
  createSecrets
  createService
}

function deleteAll() {
  deleteService
  deleteSecrets
}

function recreateAll() {
  deleteAll
  createAll
}

function scaleUp() {
  oc scale --replicas=1 dc/${SERVICE_NAME}
}

function scaleDown() {
  oc scale --replicas=0 dc/${SERVICE_NAME}
}

case ${1} in
   createAll|deleteAll|recreateAll|\
   createSecrets|deleteSecrets|recreateSecrets|\
   createService|deleteService|recreateService|\
   scaleUp|scaleDown)
      ${1}
      ;;
   *)
     echo "${0} [   createAll|deleteAll|recreateAll|\
     createSecrets|deleteSecrets|recreateSecrets|\
     createService|deleteService|recreateService|\
     scaleUp|scaleDown]"
     exit 1
      ;;
esac
