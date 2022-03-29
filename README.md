# SSP Flight 1K1
The Buran Orbiter November 15, 1988 test flight reconstruction.

![scr](https://user-images.githubusercontent.com/100083998/160516510-4aac0205-abd5-4565-9e2f-4f8351b6a220.jpg)

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



