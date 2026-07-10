# BOCHS

## macOS Setup and Usage

### 1. Installation

Install Bochs and its dependencies using Homebrew:

```sh
brew install bochs sdl sdl2 libtool
```

### 2. Running Bochs

Navigate to the `projects/31_day/harib28a` directory, which contains Bochs configuration files for both Linux and macOS.
To run Bochs on macOS, use the following command:

```sh
bochs -f bochsrc_macos.txt
```

Note: The Bochs configuration file path differs between Linux and macOS. Ensure you're using the correct file for your operating system.
