# MicroPython on Teensy 4.1 with RunCam Split 4

This guide will help you set up MicroPython on the Teensy 4.1 and interface it with the RunCam Split 4.

## Prerequisites

- Linux Ubuntu
- Teensy 4.1
- RunCam Split 4
- MicroUSB cable
- Required Python packages: `pip3`, `adafruit-ampy`

## Step-by-Step Instructions

### Step 1: Install Dependencies

1. Update package lists:
    ```bash
    sudo apt update
    ```

2. Install pip:
    ```bash
    sudo apt install python3-pip
    ```

3. Install `adafruit-ampy`:
    ```bash
    pip3 install adafruit-ampy
    ```

4. Install `screen`:
    ```bash
    sudo apt install screen
    ```

### Step 2: Flash MicroPython Firmware to Teensy 4.1

1. Download the MicroPython firmware for Teensy 4.1 from the [MicroPython website](https://micropython.org/download/TEENSY41/).

2. Ensure the Teensy Loader CLI is installed and compiled:
    ```bash
    git clone https://github.com/PaulStoffregen/teensy_loader_cli.git
    cd teensy_loader_cli
    make
    ```

3. Create a udev rules file for Teensy:
    ```bash
    sudo nano /etc/udev/rules.d/49-teensy.rules
    ```

    Add the following content:
    ```plaintext
    # UDEV Rules for Teensy boards
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="0478", ENV{ID_MM_DEVICE_IGNORE}="1"
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="0483", ENV{ID_MM_DEVICE_IGNORE}="1"
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="0486", ENV{ID_MM_DEVICE_IGNORE}="1"
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="048a", ENV{ID_MM_DEVICE_IGNORE}="1"
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="048b", ENV{ID_MM_DEVICE_IGNORE}="1"
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04b3", ENV{ID_MM_DEVICE_IGNORE}="1"
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04b4", ENV{ID_MM_DEVICE_IGNORE}="1"
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04b9", ENV{ID_MM_DEVICE_IGNORE}="1"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", MODE:="0666"
    KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE:="0666"
    ```

4. Reload udev rules:
    ```bash
    sudo udevadm control --reload-rules
    sudo udevadm trigger
    ```

5. Unplug and replug the Teensy 4.1 to apply the new rules.

6. Flash the firmware:
    ```bash
    sudo ~/projects/teensy_loader_cli/teensy_loader_cli --mcu=imxrt1062 -v -w TEENSY41-20240602-v1.23.0.hex
    ```

### Step 3: Upload the MicroPython Script

1. Create a MicroPython script `runcam.py`:
    ```python
    from machine import UART
    import time

    uart = UART(1, baudrate=9600, tx=1, rx=0)

    def send_command(command):
        uart.write(command)
        print("Command sent:", command)

    start_recording = b'\x00\x01'
    send_command(start_recording)
    ```

2. Upload the script:
    ```bash
    sudo ampy --port /dev/ttyACM0 put runcam.py
    ```

### Step 4: Test the Setup

1. Connect to the serial monitor:
    ```bash
    sudo screen /dev/ttyACM0 115200
    ```

2. Run the script:
    ```python
    import runcam
    ```

3. Verify the output.

### Conclusion

By following these steps, you should be able to set up MicroPython on the Teensy 4.1 and communicate with the RunCam Split 4. If you encounter any issues, ensure all connections are secure and double-check your wiring and scripts.
