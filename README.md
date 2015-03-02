![CoreBeam Logo](/logo/corebeam-logo-github.png)

CoreBeam is a low cost DIY laser cutter/engraver based on [CoreXY](http://corexy.com/) kinematics. Its size can be scaled easily to suit your requirements and without the need to reprint parts.

### CoreBeam Key Features
- low cost, entry-level solution
- easy to build and assemble with basic hobbyist tools
- workspace size can be increased easily

### What electronics/firmware have been used?
The machine is controlled by a slightly modified version 0.8 of [grbl](http://www.github.com/grbl/grbl/) running on an Arduino Uno with grbl-shield, a custom hand-soldered MOSFET-PCB and a cheap current limiting circuit-board.

### Which software can I use?
Due to using grbl as firmware a wide range of software can be used with CoreBeam. For streaming g-code via USB both [Universal G-Code Sender](https://github.com/winder/Universal-G-Code-Sender) and [GrblController](https://github.com/zapmaker/GrblHoming) have been tested successfully. Designing vector-images and converting them into g-code is easy as pie with [InkScape](https://inkscape.org) and the [LaserEngraver](http://www.slackersdelight.com/instructables/laserengraver.zip) extension, a heavily modified version of [Gcodetools](http://www.cnc-club.ru/forum/viewtopic.php?f=15&p=101).

### What materials can be handled?
Using a 2W 445nm M140 blue laser diode, CoreBeam has been tested for working with the following materials:

| Material | Cut | Engrave |
| :------------- | :-------------: | :-------------: |
| Paper (any color) | Yes | Yes |
| Cardboard (any color) | Yes | Yes |
| Corrugated cardboard | Yes | Yes |
| Foam rubber (Polyurathane) | Yes | Yes |
| Synthetic felt | Yes | Yes |
| Wood (<= 1mm) | Yes | Yes |
| Wood (> 1mm) | No | Yes |
| Leather (<= 3mm) | Yes | Yes |
| Self-adhesive foils | Yes | Yes |
| Acrylic | No | Yes |
| Metal | No | No |

### Safety warnings
A powerfull laser diode is **not a toy**. Focused laser beams can burn your skin and damage your eyes permanently if not used responsibly. Please do yourself a favor and always use suitable, **certified laser goggles** while working with your laser cutter/engraver.
I do recommend operating CoreBeam only in well ventilated areas and only on materials **not emitting toxic fumes**.
