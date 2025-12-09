every racket language has a reader and an expander
Every reader must export a read-syntax func­tion
Racket passes two argu­ments to read-syntax: the path to the source file, and a port for reading data from the file. 
