dataref
=======

Writing scientific texts is a craft. It is the craft of communicating your results to
your colleagues and to the curious world public. Often your conclusions are based
upon facts and numbers that you gathered during your research for the specific
topic. You might have done many experiments and produced lot of data. The
craft of writing is to guide your reader through a narrative that is based upon
that data. But there may be many versions of that data. Perhaps you found a
problem in your experiment, while already writing, that forces you back into the
laboratory. After a while, the moon has done its circle many times, you return
from that dark place and your methodology has improved as significantly as your
data has. But now you have to rewrite that parts of the data, that reference the
old data points.
The dataref is here to help you with managing your data points. It provides
you with macro style keys, that represent symbolic names for your datapints.
You can reference those symbolic names with \dref, use them in calculations
to have always up-to-date percentage values, define projections between sets of
data points and document them. dataref also introduces the notion of assertions
(\drefassert) for your results to ensure that your prosa text references fit the
underlying data.

Building the documentation
==========================
With latexmk installed:

    make

or

    pdflatex dataref.tex; pdflatex dataref.tex; pdflatex dataref.tex


Examples
========

Setting symbolic data points

    \drefset{/count}{42}
    \drefset{/abc}{23}

Referencing them with \dref, \drefcalc, \drefassert

    \dref{/count}  => 42
    \drefcalc{data("/abc") / data("/count")} => 0.55
    \drefassert{data("/abc") < data("/count")}

Getting the latest version
==========================

dataref is hosted at github: https://github.com/stettberger/dataref
