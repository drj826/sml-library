# Semantic Manuscript Language (SML) Documentation Library

This is a library of documents about the Semantic Manuscript Language
(SML).  SML is a minimalistic plain text descriptive markup language
designed to:

- be human readable

- enable continuous integration of documentation

- express and validate semantic relationships

- be easy to edit

- be easy to generate automatically

- publish complex documents

- publish libraries of related documents

Why call it "Semantic Manuscript Language?"

SML enables you to express the semantics (meaning) of the text so that
applications can automatically reason about document content.

A manuscript is the original form for a published document. Authors
use SML to capture ideas in an original form that can be processed and
published into multiple renditions.

The concept of a "semantic manuscript" aligns well with my purpose to
enable authors to create readable, modular, documents and re-usable
document fragments which can be automatically published to multiple
renditions and processed by applications that can reason about their
meaning.

SML enables you to represent full-length, full-featured, high-quality
books, reports, and articles in minimally formatted text files. Its
simple mark-up rules ensure the plain text manuscript is easy to read,
but still contains everything necessary to turn the text into a
professionally typeset hardcopy or web content.

SML documents can be rendered to:

- HyperText Markup Language (HTML)

- LaTeX

- Portable Document Format (PDF) (via LaTeX)

SML is free (licensed under the General Public License (GPL)). I've
implemented a free codebase in Perl 5 that includes a parser and
publisher.