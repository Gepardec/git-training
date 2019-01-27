#!/bin/bash

# tag::init[]
# Initialize git repository (within the directory we are in)
git init
# Show the status before the commit
git status
# Add all files to the git index
git add --all
# Commit the sources
git commit -a -m "Initial checkin"
# Show the status after the commit
git status
# end::init[]

# tag::branch-model[]
# Create the branches in proper order from the proper predecessor
git checkout master
git checkout -b dev
git branch feature
# end::branch-model[]

# tag::first-release[]
# Ensure your are on the poroper commit = branch!!
git checkout master
# Creates an annotated tag named 'v1.0'
git tag -a -m "This is the first release" v1.0
git tag -l
# end::first-release[]

# tag::fix-dev[]
# Swithch to dev branch
git checkout dev
# Commit the change
git commit -a -m "Fix for broken shell script"
git status
# end::fix-dev[]

# tag::fix-hotfix[]
# Create hotfix branch and commit fix
git checkout master
git checkout -b hotfix
git commit -a -m "Fix for insufficent resources"
# Release the fix
git checkout master
git merge hotfix
git tag -a -m "Hotfix release fixing insufficent resources"
# Reintegrate the hotfix
git checkout dev
git merge hotfix
# end::fix-hotfix[]

# tag::release-feature[]
# Merge dev -> feature !! Remember the conflict !!!
git checkout feature
git merge dev
git commit -a -m "Merged dev branch to feature branch"
# Merge feature -> dev
git checkout dev
git merge feature
# Release the feature
git checkout master 
git merge dev
git tag -a -m "Feature relase for recreating the swagger service"
# end::release-feature[]
