FAR - Find And Replace 1.7 (25-02-2013)

A GUI for find and replace operations accross multiple files in entire directory trees. 
With or without regular expressions. Special support for expressions spanning multiple lines.


CREDITS:

Special thanks to the Launch4j team (http://launch4j.sourceforge.net) for providing the tool
to create a windows executable.

And another: "ICO File Tool" (https://sourceforge.net/projects/icofiletool/) allows to create
multi image .ico files.


RELEASE NOTES

Installation & Removal:
Unpack the archive (zip or tar.gz) at a location of your choice, e.g. "C:\Program Files" or
"/opt". The archive will create a subdirectory "far" that contains everything. To uninstall,
delete that directory.


Running:
Double click the application icon.
See the Help > Manual menu section for instructions how to use FAR.


License:
FAR is released under the GNU General Public License version 3.0. 
It includes libraries from the Apache Software Foundation, released under Apache License 2.0.
See the licenses directory for details. 


System:
Requires Java 1.5 (or later) in your path. Run 
:> java -version
on your command line to verify you have it.


KNOWN LIMITATIONS

Large Files:
Processing and display of very large files (several MB, depending on system RAM) may lead
to OutOfMemoryErrors. FAR will indicate that the file can not be displayed/processed.
While there is a machine dependent upper bound for display, processing will 
typically work even with large files, unless such file contains only very few matches
(but at least one). Thus it may still be possible to process a file (in a replace operation), 
even if it can not be displayed. The only workaround for this is to reduce file size. 

Opening File/Directory from Context Menu:
The options "Open file" and "Open Directory" from the file list context menu may not work
on certain operating systems. Instead of starting the default application or the platform
file browser, only an error message will be shown. Linux with KDE and Java 6 is known to
display this behaviour, while Windows is generally not affected. This is a JVM (Java) bug.
Note that neither option is available when running FAR with Java 5 (any OS).


http://findandreplace.sourceforge.net