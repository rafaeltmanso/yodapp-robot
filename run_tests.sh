#!/bin/bash
# Run Robot Framework tests with logs directory as output

# Create logs directory if it doesn't exist
mkdir -p logs

# Run Robot Framework tests with output directed to logs folder
robot --outputdir logs tests
