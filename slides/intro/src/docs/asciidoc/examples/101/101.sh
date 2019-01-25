#!/bin/bash

# tag::init[]
# Initialize git repository (within the directory we are in)
git init
# Create a README.adoc file
echo "= My app documentation" > README.adoc
# Add all files to the git index
git add --all
# Commit the sources
git commit -a -m "Initial checkin"
# end::init[]

# tag::branch-model[]
# Create branch dev
git branch dev
# Create branch feature
git branch feature
# end::branch-model[]

# tag::first-release[]
# Creates an annotated tag named 'v1.0'
git tag -a -m "This is the first release" v1.0
# end::first-release[]

# tag::conflicting-commit[]
# Swithch to branch dev
git checkout dev
# Modify the README.adoc
echo -e "\n\n== What is the app for?" >> README.adoc
# Commit the change
git commit -a -m "Initial checkin"
# end::conflicting-commit[]
