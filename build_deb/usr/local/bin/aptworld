import os
import json

# Uses 'apt-mark showmanual' to get a set of manually installed packages.
def get_manual_packages():
    try:
        with os.popen("apt-mark showmanual") as f:
            manual_packages = set(line.strip() for line in f if line.strip())
        return manual_packages
    except Exception as e:
        raise RuntimeError(f"Failed to get manual packages: {e}")

#Parses the dpkg status file and returns a dict of installed packages.
    #Only returns packages with 'install ok installed' status.
    
def parse_dpkg_status(status_file="/var/lib/dpkg/status"):
    installed_packages = {}
    try:
        with open(status_file, "r", encoding="utf-8") as f:
            pkg_info = {}
            for line in f:
                line = line.strip()
                if not line:
                    if pkg_info.get("Status") == "install ok installed":
                        pkg_name = pkg_info.get("Package")
                        if pkg_name:
                            installed_packages[pkg_name] = pkg_info
                    pkg_info = {}
                else:
                    if ":" in line:
                        key, val = line.split(":", 1)
                        pkg_info[key.strip()] = val.strip()
    except FileNotFoundError:
        raise FileNotFoundError(f"Status file {status_file} not found.")
    except Exception as e:
        raise RuntimeError(f"Error reading dpkg status file: {e}")

    return installed_packages

 # Return only packages that are both manually marked and fully installed
def get_explicitly_installed_packages():
    manual_packages = get_manual_packages()
    installed_packages = parse_dpkg_status()
    explicitly_installed = {
        pkg: installed_packages[pkg]
        for pkg in manual_packages
        if pkg in installed_packages
    }
    return explicitly_installed

def main():
    try:
        packages = get_explicitly_installed_packages()
        print(f"\nExplicitly installed packages (total: {len(packages)}):\n")
        for name in sorted(packages):
            version = packages[name].get("Version", "unknown")
            print(f"{name} ({version})")

        # Save to JSON
        output = {
            name: packages[name].get("Version", "unknown")
            for name in sorted(packages)
        }
        with open("listofpackages.json", "w") as f:
            json.dump(output, f, indent=2)

        print("\nSaved to listofpackages.json")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    main()
