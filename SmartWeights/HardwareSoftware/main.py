'''Example file for the pico.'''

import machine

# Define the pin number
pin_number = 2

# Configure the pin as an input
pin = machine.Pin(pin_number, machine.Pin.IN)

# Read the pin value and print it
while True:
    value = pin.value()
    print("Pin value:", value)