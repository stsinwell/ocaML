--- Additional installations ---
sudo apt-get install gtk2.0 libblas-dev liblapack-dev
opam install lablgtk camlimages csv dsfo lacaml
(opam may need to be updated before some of these can be installed.)

The OCaml Graphics module is also required.

--- To compile all files ---
make compile

--- To run the GUI ---
make gui

The GUI is best run on a Linux machine, including the CS 3110 VM. While it
works on Mac OS X, there may be distortion in the saved drawings on some
Macs.

The user may freely draw on the GUI. The canvas can be reset by clicking the
reset button. The drawn image can be classified by the neural network by
clicking on the classify button. This also saves the image as "num.bmp" in
the images directory.

--- To run a visualization of the neural network --
make visualise

--- To clean up ---
make clean
