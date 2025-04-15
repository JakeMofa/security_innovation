# Apt World – Security_innovation

## Overview

This project is a coding challenge solution for **Apt World**, targeting **Debian 12**.

It identifies all packages **explicitly installed by the user** (like Gentoo's selected set), by parsing `/var/lib/dpkg/status` and comparing against `apt-mark showmanual`.

---

## 🔧 Project Structure
Security_innovation/ ├── aptworld.py # Python 3 script (main logic) ├── Dockerfile # Debian 12 environment setup ├── listofpackages.json # Output of manually installed packages ├── aptworld_1.0.0.deb # (optional) Debian package build └── build_deb/ # Directory to build .deb package ├── DEBIAN/control └── usr/local/bin/aptworld


---

## 🚀 How to Run (with Docker)


> This is the recommended way to run the script on macOS or other non-Debian systems.

### 1. Build the Docker image


```docker build -t aptworld .```


### 2. Run the container

``docker run --rm -v "$PWD:/app" aptworld``




## 💡 How the Script Works
1. aptworld.py
-Written in Python 3

-Runs apt-mark showmanual to get manually installed packages

-Parses /var/lib/dpkg/status for installed package metadata

-Cross-matches the results

-Outputs:

    -Readable list to the terminal

    -JSON output to listofpackages.json


## 📦 How to Build the Debian Package
# 1. Create the necessary folder structure

```mkdir -p build_deb/DEBIAN```
```mkdir -p build_deb/usr/local/bin```
```cp aptworld.py build_deb/usr/local/bin/aptworld```
```chmod +x build_deb/usr/local/bin/aptworld```

# 2. Create the control file

Create build_deb/DEBIAN/control 

Package: aptworld
Version: 1.0.0
Section: utils
Priority: optional
Architecture: all
Depends: python3
Maintainer: Name <your@email.com>
Description: CLI tool that lists explicitly installed Debian packages.
 Lightweight utility that mimics Gentoo's selected set using dpkg and apt-mark.

# 3. Build the Debian package
```dpkg-deb --build --root-owner-group build_deb aptworld_1.0.0.deb```

# 4. Install the Debian package
sudo dpkg -i aptworld_1.0.0.deb

## run the tool from any terminal
aptworld


##  Runs on  Debian 12 via docker for macos
