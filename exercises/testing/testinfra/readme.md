# TestInfra
## Introduction
Automated testing is vital to the practices of continuous integration. Having an automated test suite that can be run on demand is crucial tool in understanding whether a code change can be confidently released to production.

The type of testing that is appropriate very much depends on the nature of the thing under test. When it comes to testing that infrastructure has been built correctly there is no substitute for going and checking the infrastructure after it has been built.

There are frameworks that can help do this in lots of languages. For python there is an API called [TestInfra](https://github.com/philpep/testinfra) and it is this API that we will use for purpose of this exercise

## Objectives
Write a test to check that the provided Ansible correctly deploys and configures and instance of Apache.

## Exercise
Before we get started, take a look


following tutorial for building apache: https://www.digitalocean.com/community/tutorials/how-to-configure-apache-using-ansible-on-ubuntu-14-04


1. ansible apache -c local -m ping


Install apache on to a server.

inspec exec spec/vim_installed_test.rb -t docker://5af999c37307328b1bae89d81d00725829609d717bbee20444325131e31166d8
