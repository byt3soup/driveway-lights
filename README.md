# driveway_lights

A simple project to control driveway lights using the Energenie remote sockets, see:

https://energenie4u.co.uk/catalogue/product/ENER002-2PI

This repo includes everything you would need to get this up and running
apart from a couple of things you will need to provide yourself:

- Driveway
- Lights

## Description

Basically this allows you to control a remote device connected to these sockets with the added benefit of using the local sunset time to provide a switch on time. The switch off time is purely controlled by the crontab. You dont have to use the sunset time, you could just use a crontab entry in which can you wont need the `getinfo.sh` and `compare_times.sh`
scripts.

The way it all works is quite straighforward. The `getinfo.sh` script is run once per day this pulls the local sunset times and some other info and drops it into `todays_info.out` this is just a simple json file. Then after a certain time the crontab file simply checks every 5 mins running `compare_times.sh` if the current time is past the sunset time it calls the
`sockets/control.py` to switch on the remote socket. The same `control.py` is used to turn off the remote socket also

The `button.py` uses python flask to host a simple webpage with "on" and "off" buttons so you can control the lights from your local device. The default port of 5000 will be used but you could change this too.

## Install

Clone this repo first then add the `crontab.example` entries into your user crontab. Also you'd want to add something like this into your `/etc/rc.local`

```
su pi -c '/home/pi/driveway-lights/button.py' &
```

Once you start the `rc.local` service check with something like `netstat -lnt` to check its listening on the right port then point your device and your raspberry pi IP:port and you can be the envy of all your friends and neighbours by showing them your remote controlled driveway lights



