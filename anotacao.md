every racket language has a reader and an expander
**Every reader must export a read-syntax func­tion**
Racket passes two argu­ments to read-syntax: the path to the source file, and a port for reading data from the file. 


It turns out that a lot of things in Racket that look like normal func­tions are actu­ally copying & rewriting code when the program is compiled (an event we’ll call compile time) rather than being invoked when the program is eval­u­ated (an event we’ll call run time). Suppose we use and within a program like so:
```
(and cond-a cond-b cond-c)
```
From afar, and looks like a func­tion. But it’s not. Rather, at compile time, this use of and gets expanded—that is, rewritten—so it looks like this:
```
(if cond-a
    (if cond-b
        cond-c
        #f)
    #f)
```

At compile time, a macro takes one code frag­ment as input, and converts it to a new code frag­ment. The input & output code frag­ments are each pack­aged inside a syntax object.
Because compile time happens before run time, all macros operate before any run-time func­tions.
A macro can only treat its input code as a literal syntactic entity. It can’t eval­uate argu­ments or expres­sions within that code, because those values are only avail­able at run time (which happens after compile time).

Within the expander, we have three basic tech­niques for adding bind­ings to code:
    We can define macros that rewrite certain code as other code at compile time (for instance, and).
    We can define func­tions that are invoked at run time.
    We can import bind­ings from existing Racket modules, which can include both macros and func­tions.
    **#%module-begin. Every expander must export a #%module-begin macro.**
