#!/bin/python
import asyncio
import subprocess
from dbus_next.aio import MessageBus
from dbus_next.constants import BusType
from dbus_next import MessageType

async def main():
    battery = subprocess.run(
        "upower -e | grep battery",
        shell=True,
        capture_output=True,
        text=True
    ).stdout.split("\n")[0]

    print(battery)

    bus = await MessageBus(bus_type=BusType.SYSTEM).connect()
    introspection = await bus.introspect("org.freedesktop.UPower", battery)
    obj = bus.get_proxy_object("org.freedesktop.UPower", battery, introspection)
    iface = obj.get_interface("org.freedesktop.UPower.Device")

    def props_changed(props, invalid):
        print(props)
    
    iface.on_properties_changed(props_changed)

    print("Listening for DBus signals...")
    await asyncio.get_event_loop().create_future()

asyncio.run(main())
