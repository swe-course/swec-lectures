#!/bin/bash
mkdir -p /opt/nexus/nexus-data && chown -R 200 /opt/nexus/nexus-data
docker run --rm $1 -p 8081:8081 --name nexus -v /opt/nexus/nexus-data:/nexus-data sonatype/nexus3
