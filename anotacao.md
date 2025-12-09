every racket language has a reader and an expander
Every reader must export a read-syntax func­tion
Racket passes two argu­ments to read-syntax: the path to the source file, and a port for reading data from the file. 


It turns out that a lot of things in Racket that look like normal func­tions are actu­ally copying & rewriting code when the program is compiled (an event we’ll call compile time) rather than being invoked when the program is eval­u­ated (an event we’ll call run time). Suppose we use and within a program like so:

(and cond-a cond-b cond-c)

From afar, and looks like a func­tion. But it’s not. Rather, at compile time, this use of and gets expanded—that is, rewritten—so it looks like this:
(if cond-a
    (if cond-b
        cond-c
        #f)
    #f)


