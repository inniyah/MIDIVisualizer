# MIDI Visualizer

A small MIDI visualizer, written in C++/OpenGL. 

![Result image](result1.png)  

## Usage

On all platforms, you can now **run the application by simply double-clicking** on it. You will then be able to select a MIDI file to load. A *Settings* panel now allows you to modify display parameters such as color, scale, lines,... Note that MIDIVisualizer is currently not able to *play* soundtracks, only *display* them.

Press `p` to play/pause the track, `r` to restart at the beginning of the track, and `i` to show/hide the *Settings* panel. 

Binaries for macOS and Windows are available in the [Releases tab](https://github.com/kosua20/MIDIVisualizer/releases).

## Compilation

Visual Studio and Xcode/Makefile projects are provided for Windows and macOS respectively. Please note that the Linux Makefile should be up-to-date, but has not been tested recently.

With make, you can build the main *midiviz* executable with `make midiviz`.
The images and shaders are packed in the executable directly (files in `src/resources`). The images source files can be regenerated using the *midiviz-packager* (code in `packager.cpp`) ; to build it and generate the image source files, run `make package`.

You will need the [GLFW3 library](http://www.glfw.org) and the [Native File Dialog library](https://github.com/mlabbe/nativefiledialog). Library binaries are provided for Windows and macOS. 


## Command-line use
### macOS and Linux

You can run the executable from the command-line, specifying a MIDI file to read, along with optional settings such as the scale and color of the notes (by setting the red, green and blue components as numbers between 0.0 and 1.0).

    ./MIDIVisualizer path/to/file.mid [scale] [red green blue]
    

### Windows

You can run the executable from the command-line, specifying a MIDI file to read, along with optional settings such as the scale and color of the notes (by setting the red, green and blue components as numbers between 0.0 and 1.0).

    MIDIVisualizer.exe path\to\file.mid [scale] [red green blue]


## Development

The main development steps were:

- loading a MIDI file, and parsing the notes contained,
- displaying a scrolling score with these notes,
- adding visual effects to embellish the visualization.

More details [on my blog](http://blog.simonrodriguez.fr/articles/28-12-2016_midi_visualization_a_case_study.html).

![Result image](result2.png) 

![Result image](result3.png) 

 

 
