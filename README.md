# SSP Flight 1K1
The Buran Orbiter November 15, 1988 test flight reconstruction.

![scr](https://user-images.githubusercontent.com/100083998/160693889-1c0130cf-f9a3-4b8c-bff7-fd7e3bf8f5a3.jpg)
![scr3_640](https://user-images.githubusercontent.com/100083998/160693909-6d8c57f5-3239-4714-bc0f-f8000d9eeb79.jpg)
![scr2_640](https://user-images.githubusercontent.com/100083998/160693935-8cf7c9cc-a654-4859-88a3-c85dfe765649.gif)

## Controls 

| Key                   | Command                                                          |
| ---                   | ---                                                              |
|                       | **Vehicle state**                                                |
| `[0..9]`              | Load vehicle state (position, velocity, systems)                 |
| `[Ctrl]+[0..9]`       | Save current vehicle state                                       |
| `[Space]`             | Reset to last loaded/saved state                                 |
|                       | **3D view**                                                      |
| `[NumPad0..9]`        | Viewpoint select                                                 |
| `[MouseMiddle]`       | Hold to 'arc rotate' current view (Num2,Num4 views only)         |
| `[Alt]+[R]`           | THREE.js renderer switch (requires application restart)          |
|                       | **Information**                                                  |
| `[H]`                 | HUD screen toggle                                                |
| `[~]`                 | The descent and landing diagram toggle                           |
| `[Alt]+[0..9]`        | Information consoles (debugging)                                 |
|                       | **Vehicle control**                                              |
| `[Enter]`             | AP/Manual switch                                                 |
| `[Ctrl]+[-\|+]`       | AP/Manual balance                                                |
| `[Arrows]`            | Attitude control: pitch and roll (yaw in the flat turn mode)     |
| `[-],[+]`             | Speed brake and (fictitious) cruise engine collective control    |
| `[Shift]+[Up\|Dn]`    | Body flap deflection angle                                       |
| `[,],[.]`             | Attitude rate limits (applies to manual control only)            |
|                       | **Miscellaneous**                                                |
| `[Pause/Break]`       | Pause simulation                                                 |
| `[Ctrl]+[Q]`          | Increase altitude                                                |
| `[Ctrl]+[/]`          | Stop rotation                                                    |
| `[Ctrl]+[.]`          | Stop vehicle (both linear and angular motion)                    |
|                       | **Moments**                                                      |
| `[Home\|End]`         | Pitch moment                                                     |
| `[Del\|PgDn]`         | Roll moment                                                      |
| `[Ins\|PgUp]`         | Yaw moment                                                       |
|                       | **Wind**                                                         |
| `[Shift]+[Del\|PgDn]` | Crosswind component                                              |
| `[Shift]+[Home\|End]` | Tail/Head wind component                                         |
| `[Shift]+[Ins\|PgUp]` | Up-/Downflow                                                     |

### References
- [Buran.Ru](https://www.buran.ru)
  - [Original flight data and other details](https://www.buran.ru/htm/algoritm.htm)
- [Wikipedia](https://en.wikipedia.org/wiki/Buran_\(spacecraft\))
- [NASA-TP-170019800023921](https://ntrs.nasa.gov/citations/19800023921)

### Licenses
- Source code - see LICENSE
- Satellite photos are from [Google Maps](https://maps.google.com), and I'am not sure about a legal use, so consider replacing them
- Flight data source plot [not included]
- Quartz regular font [not included]

---
[Open online](https://enuiskov.github.io/ssp-flight-1k1/UVS/Release/ssp-flight-1k1/index.html) - try Chromium-based web browser for best performance.
