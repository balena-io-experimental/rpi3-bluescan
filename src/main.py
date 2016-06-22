import bluetooth
import time

def find_devices():
    nearby_devices = bluetooth.discover_devices(lookup_names=True)
    print("found %d devices" % len(nearby_devices))

    for addr, name in nearby_devices:
        print("  %s - %s" % (addr, name))

if __name__ == "__main__":
    while True:
        find_devices()
        time.sleep(10)
