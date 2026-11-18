# Manuscript LaTeX Template

A minimal LaTeX template for English research papers, combining restrained journal typography with familiar conference-paper conventions. It is inspired by Nature and Science, but is not an official submission template for either journal.

The layout uses black text, Times-style fonts, and blue citations and hyperlinks. It has no logos, project branding, coloured heading blocks, or main-text table of contents. Email addresses are black and monospaced.

Repository: [fluxmx/Manuscript_LaTeX_Template](https://github.com/fluxmx/Manuscript_LaTeX_Template).

## Requirements and compilation

Use a TeX Live or MiKTeX installation containing pdfLaTeX, BibTeX, and the packages loaded by `simple.sty`. The template uses the standard `article` class with `newtxtext` and `newtxmath`.

These are **Times-style fonts, not Times New Roman**. No system fonts, XeLaTeX, Python, shell escape, or runtime downloads are required when the TeX dependencies are installed.

Compile from the repository root:

```sh
latexmk -pdf main.tex
```

Alternatively, use the standard compilation sequence:

```sh
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex
```

The PDF and auxiliary files are written beside `main.tex`. Optional Make targets are:

```sh
make        # Build main.pdf using the selected layout
make clean  # Clean auxiliary files while preserving the PDF
```

## Automatic builds on GitHub

The **Build LaTeX** workflow runs on every push and pull request. You can also
start it manually from the repository's Actions tab. It compiles `main.tex`
with pdfLaTeX and BibTeX through `latexmk`, using TeX Live 2025 and the layout
selected in the source.

Successful builds of the current `main` commit publish `main.pdf` to a single
rolling [Latest PDF release](https://github.com/fluxmx/Manuscript_LaTeX_Template/releases/tag/latest).
Each successful publication replaces the existing PDF and moves the `latest`
tag to its source commit. No per-commit PDF artifacts or release versions are
created. Pull requests and other branches only run compilation checks.

[Download the latest PDF](https://github.com/fluxmx/Manuscript_LaTeX_Template/releases/download/latest/main.pdf).
Release assets have no configured 30-day expiry; private repositories require
repository access to download them. Failed builds leave the previous successful
release in place and upload available diagnostic logs for 7 days. Generated
files are not committed back to the repository.

The workflow can only access files present in Git. Since `figures/` is ignored
by default, explicitly track any figures required for a cloud build, or adjust
`.gitignore` before adding them. GitHub Actions must be enabled for the repository.

## Single-column and two-column layouts

Select the layout when loading the style in `main.tex`. Use one of these lines:

```latex
\usepackage[singlecolumn]{simple} % Single-column article (default)
\usepackage[twocolumn]{simple}    % Two-column body; full-width title and abstract
```

Without options, `\usepackage{simple}` defaults to a single column. `onecolumn` is an alias for `singlecolumn`.

Both layouts use the same `main.tex` and content files. Keep the standard `\maketitle` followed by the `abstract` environment; the style arranges the full-width opening automatically. There is no need to insert `\twocolumn` manually or maintain a second main file.

## Files to edit

| File | Purpose |
| --- | --- |
| `main.tex` | Main entry point and layout option |
| `math_commands.tex` | Shared mathematical notation and operators |
| `metadata.tex` | Title, authors, affiliations, contribution notes, and email |
| `frontmatter.tex` | Standard title and abstract commands |
| `sections/abstract.tex` | Abstract text |
| `sections/body.tex` | Main text, figures, tables, and equations |
| `references.bib` | BibTeX references |
| `content.tex` | Main-text, bibliography, and optional appendix inclusion |
| `sections/supplement.tex` | Supplementary methods and derivations |
| `simple.sty` | Shared typography and layout settings |

Use ordinary LaTeX commands such as `\section`, `\subsection`, `\cite`, `\label`, `\ref`, and `\eqref`. The example prose is a writing guide, not a scientific report. The sample bibliography entry demonstrates citation formatting and does not support the placeholder prose.

### Title and authors

Enter the title as continuous text with normal spaces:

```latex
\title{Your paper title}
```

Avoid manual line breaks (`\\`) or nonbreaking spaces inside the title. It uses the full available width, aligns left, and wraps naturally without forcing balanced line lengths. Actual arXiv HTML conversion should still be checked during submission.

Use standard `\author`, `\textsuperscript`, and `\\` commands for the author and affiliation block. Keep all affiliation lines in one `\small` group and end its paragraph with `\endgraf` before closing the group, as in `metadata.tex`. This keeps every affiliation line at the same line spacing. Use the same pattern for the `\footnotesize` contribution and contact block. Inside `\author`, use `\endgraf` instead of a literal `\par`.

Enter each email address only once:

```latex
\email{author@example.com}
```

This creates a clickable `mailto:` link while keeping the displayed address black and monospaced.

### Sections, figures, and tables

Main-text headings are unnumbered by default. Citations use superscript numbers; figures, tables, and equations remain numbered. If numbered main-text headings are needed, add this after loading the style:

```latex
\setcounter{secnumdepth}{2}
\titleformat{\section}{\large\bfseries}{\thesection}{0.6em}{}
\titleformat{\subsection}{\normalsize\bfseries}{\thesubsection}{0.6em}{}
```

Do not use `\ref` to obtain a section number while headings are unnumbered.

Include figures with `\includegraphics[width=\linewidth]{...}`. In two-column mode, use standard `figure*` and `table*` environments for full-width displays. Use PDF, PNG, or JPG graphics with pdfLaTeX.

The title and abstract form a full-width opening in two-column mode. For exceptionally long author lists or abstracts, use the single-column layout.

## Mathematical notation

`main.tex` loads `math_commands.tex` after `simple.sty`. This file is copied unchanged
from the supplied macro collection and uses `amsmath`, `amsfonts`
and `bm`. It provides the following notation families:

| Commands | Purpose |
| --- | --- |
| `\R`, `\sN`, `\sZ`, `\sC` | Real numbers and other blackboard-bold sets |
| `\E`, `\Var`, `\Cov`, `\KL` | Expectation, variance, covariance and KL divergence |
| `\vx`, `\vy`, `\vtheta`, `\mA`, `\mSigma` | Vectors and matrices |
| `\tA`, `\etA` | Tensors and tensor entries |
| `\rx`, `\rvx`, `\rmA` | Random variables, vectors and matrices |
| `\gD`, `\gL`, `\train`, `\valid`, `\test` | Calligraphic symbols and datasets |
| `\argmin`, `\argmax`, `\sign`, `\Tr` | Mathematical operators |
| `\ceil{x}`, `\floor{x}` | Ceiling and floor |
| `\Figref{key}`, `\Tabref{key}`, `\Appref{key}` | References with a type prefix |

For example:

```latex
\[
  \vtheta^{\star}
  = \argmin_{\vtheta\in\R^d}
    \E_{(x,y)\sim\train}
    \bigl[\ell(f_{\vtheta}(x),y)\bigr].
\]
```

This collection redefines `\eqref{key}` to print “equation 1” rather than
“(1)”. Use `\Eqref{key}` at the start of a sentence and `\eqref{key}` within
a sentence. Do not prepend `Equation` or `Eq.` to these commands. For a bare
parenthesized number, write `(\ref{key})` explicitly. The example article and
appendix follow the supplied collection's reference conventions.

Section-reference helpers require numbered sections; main-text headings are
unnumbered by default. The imported macro collection contains other definitions
that may overlap with another template, so check it before migration. It is
separate from `simple.sty` and can be omitted by removing its `\input` line.
See `THIRD_PARTY_NOTICES.md` for provenance.

## Appendix

The appendix is disabled by default. Enable it by uncommenting these lines at the end of `content.tex`:

```latex
\appendix
\input{sections/supplement}
```

The appendix starts on a new page with the paper title, followed by “Supplementary information” and an appendix-only table of contents. This opening page is always single-column. Appendix text starts on the next page and returns to the article's selected column layout.

Appendix sections use letters, such as Appendix A and Appendix B; subsections use A.1 and A.2. Page, figure, table, and equation numbers continue from the main article. The main text has no table of contents.

The contents are generated with `titletoc`; `latexmk` repeats compilation as needed to update entries, page numbers, and links.

## Hyperlinks

The style defines pure blue links using RGB `0, 0, 255` (`#0000FF`):

```latex
\definecolor{LinkBlue}{RGB}{0,0,255}
\hypersetup{
  colorlinks=true,
  allcolors=LinkBlue
}
% \hypersetup{hidelinks}
```

This applies to citations, cross-references, URLs, and appendix contents links. Email text remains black.

Uncomment `\hypersetup{hidelinks}` in `simple.sty` to remove link colours and borders while retaining clickable links. You can also place that command after `\usepackage{simple}` in the main file.

## Submission and arXiv

Upload `main.tex`, all included `.tex` files, `simple.sty`, `references.bib`, and the figures actually used. Include the corresponding `.bbl` file when required; it is generated beside the main file. Keep only the intended main entry in the submission package to avoid ambiguous automatic compilation.

The template uses standard TeX-distribution packages to reduce dependencies, but local compilation does not guarantee acceptance by every submission platform. If a publisher requires its official class or template, migrate the article content to that template.

Check the current platform instructions before submitting:

- [TeX Live and supported processors at arXiv](https://info.arxiv.org/help/faq/texlive.html)
- [Submitting TeX/LaTeX to arXiv](https://info.arxiv.org/help/submit_tex.html)
- [The newtx font package](https://ctan.org/pkg/newtx)

## Version control and licensing

Generated PDFs, compilation files, and `output/` are ignored by Git. The `figures/` directory is also ignored; back up paper-specific graphics separately and include required graphics in submission packages.

Original code and documentation are available under the [MIT License](LICENSE).
The imported `math_commands.tex` collection is excluded from this license grant;
its upstream license has not been verified. See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)
for third-party terms and provenance.
