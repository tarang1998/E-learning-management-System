# SkillsBerg Installation Manual

## Prerequisites:

### Operating System:
Flutter supports Windows, macOS, and Linux. Ensure that your system meets the minimum requirements.

### Development Tools:
Make sure you have a code editor installed. Recommended editors include Visual Studio Code, IntelliJ IDEA, or Android Studio.

### Git:
Install Git for version control.

## Installation Steps:

### 1. Install Flutter:

#### Windows:
1. Download the Flutter SDK for Windows from the [official Flutter website](https://flutter.dev/docs/get-started/install/windows).
2. Extract the downloaded ZIP file to a location on your machine.
3. Add the `flutter/bin` directory to your system's PATH.

#### macOS:
1. Download the Flutter SDK for macOS from the [official Flutter website](https://flutter.dev/docs/get-started/install/macos).
2. Extract the downloaded ZIP file to a location on your machine.
3. Add the `flutter/bin` directory to your system's PATH.

#### Linux:
1. Download the Flutter SDK for Linux from the [official Flutter website](https://flutter.dev/docs/get-started/install/linux).
2. Extract the downloaded TAR file to a location on your machine.
3. Add the `flutter/bin` directory to your system's PATH.

### 2. Install Dart:

#### Windows, macOS, Linux:
1. Download the Dart SDK from the [Dart SDK page](https://dart.dev/get-dart).
2. Follow the installation instructions provided for your operating system.

### 3. Firebase Functions:

#### Navigate to the Firebase Functions Directory:
```bash
cd skillsberg/firebase_functions

# Firebase Functions

## Installation and Setup

1. **Navigate to the Firebase Functions Directory:**

    ```bash
    cd skillsberg/firebase_functions
    ```

2. **Install Dependencies:**

    ```bash
    npm install
    ```

3. **Run Firebase Functions Locally:**

    ```bash
    firebase emulators:start
    ```

    This will start the local Firebase emulators.

4. **Deploy Firebase Functions:**

    ```bash
    firebase deploy --only functions
    ```

5. **Deploy your functions to Firebase.**

## Verify Installation:

Open a new terminal or command prompt and run the following command to verify the installation:

```bash
# Run the following command
flutter doctor

# Cloning and Running the Flutter Project

## 4. Clone the Repository

To clone the project repository to your local machine, open the terminal on your laptop/computer and paste the following command:

```bash
git clone https://github.com/tarang1998/E-learning-management-System.git

# Steps to Run a Flutter Project

## Open a Terminal or Command Prompt

Open a terminal or command prompt on your machine.

## Navigate to Your Flutter Project Directory

Use the `cd` command to navigate to the directory where the ELMS Flutter project is located. For example:

```bash
cd path/to/your/flutter/project/web

# Run the Flutter Project

Run the following command to launch your Flutter app:

```bash
flutter run

This command will compile your Flutter project and open the localhost port 8080 where your app will be running
http://localhost:8080. If 8080 port is busy or unavailable go to the port as given by VSstudio

# Hot Reload

One of the advantages of Flutter is the hot reload feature. After making changes to your code, save the file, and Flutter will automatically update the running app without restarting it.

## Stopping the App

To stop the running app, press `Ctrl + C` in the terminal.
