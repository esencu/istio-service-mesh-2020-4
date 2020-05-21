#!/bin/bash

mvn -f frontend/pom.xml clean
mvn -f frontend/pom.xml package

mvn -f books/pom.xml clean
mvn -f books/pom.xml package

mvn -f authors/pom.xml clean
mvn -f authors/pom.xml package