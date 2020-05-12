# Java downloader for Linux
This script downloads and extracts OpenJDK. Then symlinks are created for three chanels:

- lastest: Points to the latest JDK version. Currently JDK 14
- stable: Points to the latest LTS version. Currently JDK 11
- oldstable: Legacy version of JDK. Currently JDK 1.8

This is "work in progress". When executed, the JDK distributions are located in the subdirectory "java" and can then be moved to wherever required on the target system. Depending projects should refer to the channel folders instead of absolute path directives. This allows updates without reconfiguration of applications.