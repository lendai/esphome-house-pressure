# esphome-house-pressure

Differential pressure sensor (indoor vs. outdoor) for balancing FTX ventilation.
It uses a Sensirion SDP810-125Pa and a Waveshare ESP32-C3-Zero, and reports to Homey Pro
over the ESPHome Native API.

Config: [`house-pressure.yaml`](house-pressure.yaml)

## Entities

| Entity | Description |
|---|---|
| Pressure indoor-outdoor | Main value: 5-minute moving average, Pa, 1 decimal, updated every 30 s |
| Pressure indoor-outdoor raw | Sampled every 2 s, averaged and sent every 10 s, Pa, 2 decimals |
| Pressure offset | Zero offset (Pa), subtracted from both pressure sensors, kept across reboots |
| Zero calibrate | Sets the offset so the current 5-minute average becomes 0 |
| Invert pressure sign | Flips the sign, for when the tubes are swapped |
| WiFi signal, Uptime | Diagnostics |

**Sign convention:** a positive value means **overpressure indoors**. The SDP8xx reports a positive
value when the pressure on its "+" port is higher than on its "−" port. With "+" open to indoor
air and "−" piped outdoors, positive therefore already means overpressure indoors. If your readings
come out reversed, turn on *Invert pressure sign*. The switch also flips the stored offset, so
your calibration still applies.

For radon in a house with a crawlspace you usually want a slight **overpressure** indoors
(a positive value, a few Pa). Underpressure draws soil air in.

## Wiring

Pinout from the [Sensirion SDP8xx-Digital datasheet](https://cdn.components.ru/media/PDF/8071819.pdf),
section 4 (pin 1 is marked "1" next to the connector):

| SDP810 pin | Signal | ESP32-C3-Zero pin |
|---|---|---|
| 1 | SCL | GPIO5 |
| 2 | VDD | 3V3 |
| 3 | GND | GND |
| 4 | SDA | GPIO4 |

In the datasheet's bottom view the pin order from left to right is SDA, GND, VDD, SCL. Pin 1 (SCL)
is the one marked "1" on the housing.

**Pull-ups:** use one 4.7 kΩ resistor from **GPIO4 (SDA) to 3V3** and one 4.7 kΩ resistor
from **GPIO5 (SCL) to 3V3**. Put them on the breadboard rows that hold the SDA and SCL wires.
The ESP32's internal pull-ups are turned off in the config.

Power the sensor from **3.3 V**, not 5 V (VDD range 2.7–5.5 V). This keeps the I2C levels at 3.3 V.

Why GPIO4/5: on the C3-Zero they are free. They are not strapping pins (GPIO2/8/9), not the onboard
RGB LED (GPIO10), not USB (GPIO18/19) and not UART TX/RX (GPIO20/21).

Tubes: the "+" port stays open to indoor air. The "−" port goes through the silicone tube to the
outside. Protect the outdoor tube end from wind and rain (for example, point it downward behind a
cover), or the readings will be noisy.

## Setup

```bash
python3 -m venv .venv
.venv/bin/pip install esphome
cp secrets.yaml.example secrets.yaml   # then fill in WiFi etc.
```

In `secrets.yaml`, fill in `wifi_ssid` and `wifi_password`. The API key, OTA password and fallback
password are already generated, so keep them.

### First flash (USB)

Connect the C3-Zero over USB-C. If it isn't detected, hold BOOT, tap RESET, then release BOOT.

```bash
.venv/bin/esphome run house-pressure.yaml
```

Choose the USB serial port, for example `/dev/cu.usbmodem…`. The log appears after flashing.
Look for `Sensor is SDP810-125Pa` and the I2C scan result `0x25`.

### Later updates (OTA)

```bash
.venv/bin/esphome run house-pressure.yaml --device house-pressure.local
```

Use the IP address if mDNS doesn't work.

If the device can't connect to WiFi, it opens the hotspot **"house-pressure fallback"**. The
password is `fallback_ap_password` in `secrets.yaml`. Connect to it and pick a network in the
captive portal.

## Adding it to Homey Pro

1. Install the **ESPHome** app on Homey (from the Homey App Store).
2. Go to *Devices → + → ESPHome*. Pick the discovered `house-pressure` device, or enter its IP
   address manually (port **6053**).
3. When asked, paste the **encryption key** (`api_encryption_key` from `secrets.yaml`).
4. The sensors, number, switch and button appear on the device. Use *Pressure indoor-outdoor* in flows and
   Insights.

## Zero calibration

1. Connect **both ports to the same air**. For example, disconnect the outdoor tube and leave both
   ports open indoors, or join "+" and "−" with a short tube.
2. Wait **at least 5 minutes** so the moving average fills with zero-pressure data.
3. Press **Zero calibrate** in Homey. The offset is set so the average
   becomes ≈ 0.0 Pa, and the new value appears in *Pressure offset*.
4. Reconnect the outdoor tube. Wait 5 minutes and read *Pressure indoor-outdoor*.

You can also enter the offset by hand in *Pressure offset*. The SDP810 is specified with no drift
(< 0.05 Pa/year), so calibrating once is usually enough.

## Reading the values

- **Pressure indoor-outdoor** is the value to balance against. Adjust the supply/exhaust air until it
  settles where you want it, for example +1…+3 Pa.
- **Pressure indoor-outdoor raw** shows short-term changes (wind gusts, doors, the kitchen hood). It's useful
  for spotting how much noise you get from wind.
- Logs: `.venv/bin/esphome logs house-pressure.yaml`
