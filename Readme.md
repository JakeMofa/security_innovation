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

#```bash
#```docker build -t aptworld .```


### 2. Run the container

#``docker run --rm -v "$PWD:/app" aptworld``




## 💡 How the Script Works
1. aptworld.py
Runs on Python 3

Uses apt-mark showmanual to list manually installed packages

Parses /var/lib/dpkg/status to check install status

Outputs results to:

Console (human-readable)

listofpackages.json (machine-readable)

